//
//  SignUp.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit
import FirebaseAuth
class SignUp: UIViewController {
    
    @IBAction func SignButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailSign.text!, password: passSign.text!) { (user, error) in
            if(error == nil){
                        debugPrint("Registration Successful")
                    }else{
                        debugPrint(error)
                    }
                }
    }
    
    @IBOutlet weak var emailSign: UITextField!
    
    
    @IBOutlet weak var passSign: UITextField!
    
    @IBOutlet weak var city: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
