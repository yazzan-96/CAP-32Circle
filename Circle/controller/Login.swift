    //
    //  ViewController.swift
    //  Circle
    //
    //  Created by Yazan Alraddadi on 08/05/1443 AH.
    //

    import UIKit
    import FirebaseAuth

    class Login: UIViewController {
        @IBOutlet weak var emilLog: UITextField!
        @IBOutlet weak var PassLog: UITextField!
        @IBOutlet weak var imageDesign: UIImageView!
        
        
        @IBAction func logButton(_ sender: Any) {
            Auth.auth().signIn(withEmail: emilLog.text!, password: PassLog.text!) { (user, error) in
                if(error != nil){
                    //debugPrint(error!)
                    self.showAlert( "Your email or password was incorrect. Please try again")
                }else{
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HobbiesColl") as! HobbiesColl
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
        
        
        func showAlert(_ msg: String){
            let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        @IBAction func SignUp(_ sender: Any) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUp
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
        
        
        
    }

