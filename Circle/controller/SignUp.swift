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
    
    
    var segmentedControl: UISegmentedControl!

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
                docRef.addDocument(data: ["city" :self.cityText.text! ,"username" : self.userName.text!,"age" : self.emailSign.text!,"id" : user!.user.uid ])
                
                    }else{
                        debugPrint(error)
                    }
                }
    }
    
    @IBOutlet weak var emailSign: UITextField!
    
    
    @IBOutlet weak var passSign: UITextField!
    
    
    @IBOutlet weak var city: UIPickerView!
    

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBAction func ginder(_ sender: UISegmentedControl) {
       

        switch sender.selectedSegmentIndex {
        case 0:
            print("Male")
            
        case 1:
            print("female")
            
        default:
            print("nothing")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = ["Male", "Female"]
        getUser ()
        city.delegate = self
        city.dataSource = self
        
         func loadView() {
            super.loadView()
            segmentedControl = UISegmentedControl(items: items)
                segmentedControl.selectedSegmentIndex = 0
             segmentedControl.addTarget(self, action: #selector(self.ginder(_:)), for: .valueChanged)
                self.view.addSubview(segmentedControl)
        }
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
