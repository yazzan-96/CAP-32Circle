//
//  Chat.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Chat: UIViewController , UITableViewDelegate, UITableViewDataSource ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        
    
    var messageArr = [Message]()
    var groupName = ""
    var cityName : String = ""
    
   
        
     
        // ProgressViews
    
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func logOut(_ sender: Any) {
        guard let SP = storyboard?.instantiateViewController(identifier: "Login") as? Login else {
    
            return
        }
        navigationController?.pushViewController(SP, animated: true)
    
        do{
            try! Auth.auth().signOut()
            print("signout")
        }catch {
        print("err------------------------or")
        }
    }
    
    @IBOutlet weak var table: UITableView!
    @IBAction func clickSend(_ sender: Any) {
        
        let refrence = Firestore.firestore().collection("users")
        refrence.whereField("id", isEqualTo: Auth.auth().currentUser?.uid)
            .getDocuments { snapshot, error in
                guard let snapshot = snapshot else {
                    return
                }
                let data = snapshot.documents[0].data()
                let name = data["username"] as! String
                
                
                self.msg.endEditing(true)
                self.msg.isEnabled = false
                self.sendButton.isEnabled = false
                let msgDB = Database.database().reference().child(self.cityName).child(self.groupName)
                let msgDict = ["Sender" : name , "MessageBody" : self.msg.text!]
        
        msgDB.childByAutoId().setValue(msgDict){(error,ref) in
            if(error != nil){
                debugPrint(error!)
            }else{
                debugPrint("Msg saved successfully")
                self.msg.isEnabled = true
                self.sendButton.isEnabled = true
                self.msg.text = nil
                self.table.reloadData()
            }
        }}
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        

    }
    

    @IBOutlet weak var msg: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        print (cityName)
        
        
        let nib = UINib(nibName: "ChatTableCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ChatTableCell")


      getMsgs()
        

        // Do any additional setup after loading the view.
    }
    func getMsgs(){
        let refrence = Firestore.firestore().collection("users")
        refrence.whereField("id", isEqualTo: Auth.auth().currentUser?.uid)
            .getDocuments { snapshot, error in
                guard let snapshot = snapshot else {
                    return
                }
                let data = snapshot.documents[0].data()
                let city = data["city"] as! String
        // How to delete
//        Database.database().reference().child(groupName).child("Sender").removeValue()
       
                let msgDB = Database.database().reference().child(city).child(self.groupName)
        msgDB.observe(.childAdded) { (snapShot) in
                let value = snapShot.value as! Dictionary<String,String>
                let text = value["MessageBody"]!
                let sender = value["Sender"]!
                
                let msgg = Message()
                msgg.msgBody = text
                msgg.sender = sender
                self.messageArr.append(msgg)
                debugPrint(self.messageArr.count)
                self.table.reloadData()
            }
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
}
extension Chat {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableCell", for: indexPath) as! ChatTableCell
       cell.msgView.text = messageArr[indexPath.row].msgBody
        cell.userName.text = messageArr[indexPath.row].sender
       // cell.userName.text = "ok"
        print(messageArr.count)
        cell.imageProfile.image = UIImage(systemName: "person.fill")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80

    }
}
