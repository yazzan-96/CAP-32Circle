//
//  SignUp.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUp: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var ages : Int = 0
    
    @IBOutlet weak var emailSign: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passSign: UITextField!
    @IBOutlet weak var city: UIPickerView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var ginder: UISegmentedControl!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    
    
    
    let listOfCity : [String] = ["Medina", "Jeddah","Riyadh","Mecca","Dammam","Abha","Tabuk","Tayef","Arar","Qasim","Hail"]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfCity.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfCity[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityText.text = listOfCity[row]
        cityText.resignFirstResponder()
        print(listOfCity[row])
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString (string: listOfCity[row] ,attributes : [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    

    
    let db = Firestore.firestore()
    
    func getUser (){
        let docRef = db.collection("users")
        docRef.getDocuments() { (querySnapshot, err) in
            // Force the SDK to fetch the document from the cache. Could also specify
            // FirestoreSource.server or FirestoreSource.default.
            for document in querySnapshot!.documents {
                print("\(document.data())"  )}
            
        }
    }
    
    
    
    @IBAction func SignButton(_ sender: Any) {
        
        if validFilelds() != nil {
            errorLabel.text = "please fill all text"
            errorLabel.isHidden = false
        }
        else {
            
            errorLabel.isHidden = true
            
            Auth.auth().createUser(withEmail: emailSign.text!, password: passSign.text!) { [self] (user, error) in
                
                if(error == nil){
                    debugPrint("Registration Successful")
                    let docRef = self.db.collection("users")
                    docRef.addDocument(data: ["city" :self.cityText.text! ,"username" :  self.userName.text!,"id" : user!.user.uid , "ginder" : self.ginder.selectedSegmentIndex == 0 ? "male" : "female", "email" : self.emailSign.text! , "phonenumber" :self.phoneNumber.text])
                    let push =
                    self.storyboard?.instantiateViewController(identifier: "Login") as! Login
                    self.navigationController?.pushViewController( push, animated: true)
                    let title = "Registration"
                    let massage = "Successful"
                    let alertController = UIAlertController(title: title , message: massage, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    
                }else{
                    self.errorLabel.text = error?.localizedDescription
                    errorLabel.isHidden = false
                    debugPrint(error)
                }
                
            }
        }}
    
    
    func validFilelds() -> String? {
        
        if userName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            cityText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailSign.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passSign.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            return "Please fill in all fields"
            
        }
        return nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getUser ()
        city.delegate = self
        city.dataSource = self
        
        func loadView() {
            super.loadView()
        
        }
        // Do any additional setup after loading the view.
    }
    
}
