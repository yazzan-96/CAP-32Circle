//
//  Chat.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class Chat: UIViewController , UITableViewDelegate, UITableViewDataSource  {
    var messageArr = [Message]()
    
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func logOut(_ sender: Any) {
        do{
            try! Auth.auth().signOut()
        }catch {
            debugPrint(error)
        }
    }
    
    @IBOutlet weak var table: UITableView!
    @IBAction func clickSend(_ sender: Any) {
        
        msg.endEditing(true)
        msg.isEnabled = false
        sendButton.isEnabled = false
        let msgDB = Database.database().reference().child("Messages")
        let msgDict = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : msg.text!]
        msgDB.childByAutoId().setValue(msgDict){(error,ref) in
            if(error != nil){
                debugPrint(error)
            }else{
                debugPrint("Msg saved successfully")
                self.msg.isEnabled = true
                self.sendButton.isEnabled = true
                self.msg.text = nil
            }
        }
    }
    
  

    @IBOutlet weak var msg: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        let nib = UINib(nibName: "ChatTableCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ChatTableCell")


      getMsgs()

        // Do any additional setup after loading the view.
    }
    func getMsgs(){
            let msgDB = Database.database().reference().child("Messages")
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
