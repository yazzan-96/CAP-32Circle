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
    
    
    
//    var picker : UIPickerView
    
    let listOfCity : [String] = ["Medina", "Jeddah","Riyadh","Mecca","Dammam","Abha","Tabuk","Tayef","Arar","Qasim","Hail"]
    
//    let age =
    
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
        
        

        // Force the SDK to fetch the document from the cache. Could also specify
        // FirestoreSource.server or FirestoreSource.default.
        docRef.getDocuments() { (querySnapshot, err) in
              
                for document in querySnapshot!.documents {
                    print("\(document.data())"  )}
        
                          }
                          }
    
    @IBAction func SignButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailSign.text!, password: passSign.text!) { (user, error) in
            if(error == nil){
                        debugPrint("Registration Successful")
                let docRef = self.db.collection("users")
                docRef.addDocument(data: ["city" :self.cityText.text! ,"username" :  self.emailSign.text!,"id" : user!.user.uid , "ginder" : self.ginder.selectedSegmentIndex == 0 ? "male" : "female", "email" : self.emailSign.text! , "age" :self.age.text])
                
                    }else{
                        debugPrint(error)
                    }
                }
    }
    
    @IBOutlet weak var emailSign: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var passSign: UITextField!
    
    
    @IBOutlet weak var city: UIPickerView!
    

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var ginder: UISegmentedControl!
    
    
    
    

    
    
    
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
