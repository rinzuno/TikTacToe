import UIKit

class Register: UIViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var UnameReg: UITextField!
    @IBOutlet weak var PwordReg: UITextField!
    @IBOutlet weak var ConfirmPass: UITextField!
    var size = 0
    // check if existing
    func check(_ UnameReg: String, _ sz: Int) -> Bool {
        for i in 0...sz {
            let tempStr = defaults.string(forKey: "Username" + String(i))
            if(UnameReg == tempStr) {
                return false
            }
        }
        return true
    }
    
    @IBAction func ConfirmReg(_ sender: Any) {
        let successMessage = UIAlertController(title: "Registered Successfully!", message: "Welcome!", preferredStyle: .alert)
        // store if existing
        if defaults.object(forKey: "size") != nil {
            size = defaults.integer(forKey: "size")
        }
        if UnameReg.text?.isEmpty == true || PwordReg.text?.isEmpty == true || ConfirmPass.text?.isEmpty == true {
            let errorMessage = UIAlertController(title: "Register Failed", message: "Make sure all information is filled", preferredStyle: .alert)
                    
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
                })
                    
            //Add OK button to a dialog message
            errorMessage.addAction(ok)
            // Present Alert to
            self.present(errorMessage, animated: true, completion: nil)
        }
        else if (PwordReg.text != ConfirmPass.text) {
            let errorMessage = UIAlertController(title: "Register Failed", message: "Passwords should be the same", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
                })
            errorMessage.addAction(ok)
            self.present(errorMessage, animated: true, completion: nil)
        }
        else {
            if size == 0 {
                defaults.set(UnameReg.text, forKey: "Username" + String(size))
                    
                defaults.set(PwordReg.text, forKey: "Password" + String(size))
                defaults.set(size+1, forKey: "size")
                defaults.set(0,forKey: "Username" + String(size) + "winr")
                defaults.set(0,forKey: "Username" + String(size) + "drawr")
                defaults.set(0,forKey: "Username" + String(size) + "loser")
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                    self.dismiss (animated: true, completion: nil)
                    })
                successMessage.addAction(ok)
                self.present(successMessage, animated: true, completion: nil)
            } else {
                if check(UnameReg.text!, size) {
                    defaults.set(UnameReg.text, forKey: "Username" + String(size))
                    defaults.set(PwordReg.text, forKey: "Password" + String(size))
                    defaults.set(0,forKey: "Username" + String(size) + "winr")
                    defaults.set(0,forKey: "Username" + String(size) + "drawr")
                    defaults.set(0,forKey: "Username" + String(size) + "loser")
                    defaults.set(size+1, forKey: "size")
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                        self.dismiss (animated: true, completion: nil)
                        })
                    successMessage.addAction(ok)
                    self.present(successMessage, animated: true, completion: nil)
                    
                    
                } else {
                    let userEx = UIAlertController(title: "Register Failed", message: "Username already exist!", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                        })
                                    
                    //Add OK button to a dialog message
                    userEx.addAction(ok)
                    // Present Alert to
                    self.present(userEx, animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func CancelReg(_ sender: Any) {
        dismiss (animated: true, completion: nil)
        
    }
}
