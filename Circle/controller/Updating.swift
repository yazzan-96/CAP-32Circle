//
//  Updating.swift
//  Circle
//
//  Created by Yazan Alraddadi on 22/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol UpdateDelegate {
  func updateName(name : String)
}
class Updating: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var delegate: UpdateDelegate!


    
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
    
    @IBOutlet weak var name: UITextField!
        
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var city: UIPickerView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ginder: UISegmentedControl!
    
    
    let db = Firestore.firestore()

    var docId = ""
    
    func getUser (){
        let docRef = db.collection("users")
        
        // Force the SDK to fetch the document from the cache. Could also specify
        // FirestoreSource.server or FirestoreSource.default.
        docRef.getDocuments() { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                if let values = document.data() as? [String : String] {
                    if Auth.auth().currentUser?.uid == values["id"] {
                        self.docId = document.documentID
                        self.updating()
                    }
                }
            }
        }
    }
    
    
    func updating () {
            db.collection("users").document(docId).getDocument { snap, err in
                guard let snap = snap else { return }
                let values = snap.data()
                let user = values?["username"] as? String
                let citty = values? ["city" ] as? String
                self.cityText.text = citty
                self.name.text = user!
        }
    }
    
    
    @IBAction func saveUpdating(_ sender: Any){
    
        self.db.collection("users").document(docId).setData(["city" :self.cityText.text! ,"username" : self.name.text!],merge:true)
        
//        db.collection("users").document("ZUaiHh4z3QDx1cPVXc0z").setData(["username" : "jtgjgjgjmgmjc"])

        guard let SP = storyboard?.instantiateViewController(identifier: "HobbiesColl") as? HobbiesColl else {
        
        return
    }
    navigationController?.pushViewController(SP, animated: true)
        

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        city.delegate = self
        city.dataSource = self
        getUser()
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
