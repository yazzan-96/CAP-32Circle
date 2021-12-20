//
//  ViewController.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit
import FirebaseAuth

class Login: UIViewController {
    
    
    @IBAction func logButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emilLog.text!, password: PassLog.text!) { (user, error) in
                    if(error != nil){
                        debugPrint(error!)
                        self.showAlert( "Your email or password was incorrect. Please try again")
                    }else{
                          
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HobbiesColl") as! HobbiesColl
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
        }
    }
    
    @IBOutlet weak var emilLog: UITextField!
    
    @IBOutlet weak var PassLog: UITextField!
    
    func showAlert(_ msg: String){
            let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
              
              
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        
        // Do any additional setup after loading the view.
    }


}

