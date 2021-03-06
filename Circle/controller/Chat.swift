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
    
//    var array = images[indexPath.row].imageName
    var key : String = ""
    let picker = UIImagePickerController()
    
    var messageArr = [Message]()
    var groupName = ""
    var cityName : String = ""
    let db = Database.database().reference()
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var msg: UITextField!
    
    
    
    func configureControls() {
        
        // UIPickerView
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.title = "Choose Image"
        
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        present(picker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        let data = image.jpegData(compressionQuality: 0.05)
        let fbStorage = Storage.storage().reference()
        let randomNumber = Int.random(in: 1...2000)
        let imgRef = fbStorage.child("imageCollection/newimage\(randomNumber).png")
        let task = imgRef.putData(data!)
        task.observe(.success) { snapshot in
            imgRef.downloadURL { url, error in
                if (url != nil) {
                    self.sendImageToFB(url: url!.absoluteString)
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func sendImageToFB(url: String) {
        
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
                let msgDict : [String : Any] = [
                    "Sender" : name ,
                    "type" : 1,
                    "imgUrl" : url
                    
                ]
                
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
    
    // ProgressViews
    
    func getMsgs(){
        let refrence = Firestore.firestore().collection("users")
        refrence.whereField("id", isEqualTo: Auth.auth().currentUser?.uid)
            .getDocuments { snapshot, error in
                guard let snapshot = snapshot else {
                    return
                }
                if snapshot.documents.count > 0 {
                    let data = snapshot.documents[0].data()
                    let city = data["city"] as! String
                    let msgDB = Database.database().reference().child(city).child(self.groupName)
                    msgDB.observe(.childAdded) { (snapShot) in
                        if let value = snapShot.value as? Dictionary<String, Any> {
                            let text = value["MessageBody"] as? String
                            var sender = value["Sender"] as? String
                            let type = value["type"] as? Int
                            let imgUrl = value["imgUrl"] as? String
                            let time = value ["date"] as? String
                            let userId = value["userId"] as? String
                            let massageId = value ["massageId"] as? String
                            if userId == Auth.auth().currentUser?.uid{sender = "You"}
                            
                            let msgg = Message()
                            msgg.msgBody = text ?? "-"
                            msgg.sender = sender ?? "-"
                            msgg.type = type ?? 0
                            msgg.imgUrl = imgUrl
                            msgg.date = time ?? "_"
                            msgg.userId = userId ?? "_"
                            msgg.massageId = massageId ?? "_"
                            self.loadFromUrl(url: imgUrl) { img in
                                msgg.imgMsg = img
                                DispatchQueue.main.async {
                                    self.table.reloadData()
                                }
                            }
                            self.messageArr.append(msgg)
                            debugPrint(self.messageArr.count)
                            self.table.reloadData()
                        }
                    }}
            }
    }
    
    
    
    @IBAction func clickSend(_ sender: Any) {
        
        let refrence = Firestore.firestore().collection("users")
        refrence.whereField("id", isEqualTo: Auth.auth().currentUser?.uid)
            .getDocuments { snapshot, error in
                guard let snapshot = snapshot else {
                    return
                }
                if snapshot.documents.count > 0 {
                    let data = snapshot.documents[0].data()
                    let name = data["username"] as! String
                    
                    
                    self.msg.endEditing(true)
                    self.msg.isEnabled = false
                    self.sendButton.isEnabled = false
                    let msgDB = Database.database().reference().child(self.cityName).child(self.groupName)
                    let newChatRef = msgDB.childByAutoId()
                    
                    let msgDict : [String : Any] = [
                        "Sender" : name ,
                        "MessageBody" : self.msg.text!,
                        "date" : Date.now.formatted(.dateTime),
                        "type" : 0,
                        "userId" : Auth.auth().currentUser!.uid,
                        "massageId" : newChatRef.key!
                    ]
                    
                    newChatRef.setValue(msgDict){(error,ref) in
                        self.key = (ref.key!)
                        print(ref)
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
    }
    
    
    
    
    
    
    
    
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(groupName) Chat"
        configureControls()
        table.delegate = self
        table.dataSource = self
        let nibb = UINib(nibName: "ImageCellTableViewCell", bundle: nil)
        table.register(nibb, forCellReuseIdentifier: "ImageCellTableViewCell")
        
        
        let nib = UINib(nibName: "ChatTableCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ChatTableCell")
        getMsgs()
        
        
        // Do any additional setup after loading the view.
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


extension Chat {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let msgType = messageArr[indexPath.row].type
        
        if (msgType == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableCell", for: indexPath) as! ChatTableCell
            cell.msgView.text = messageArr[indexPath.row].msgBody
            cell.userName.text = messageArr[indexPath.row].sender
            cell.date.text = messageArr[indexPath.row].date
            print(messageArr.count)
            cell.imageProfile.image = UIImage(systemName: "person.fill")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCellTableViewCell", for: indexPath) as! ImageCellTableViewCell
            
            if let imageMessage = messageArr[indexPath.row].imgMsg {
                cell.imageCell.image = imageMessage
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let msgType = messageArr[indexPath.row].type
        if (msgType == 0) { return 100} else {
            return 200}
        
    }
    
    // Downloads image from Cloud
    func loadFromUrl (url: String?, completion: @escaping (UIImage)->Void) {
        
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, _) in
            guard let data = data else { return }
            let imageFromCloud = UIImage(data: data)!
            completion(imageFromCloud)
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if messageArr[indexPath.row].userId == Auth.auth().currentUser!.uid {
            let massage = messageArr[indexPath.row].massageId
            
            if editingStyle == .delete {
                db.child(self.cityName).child(self.groupName).child(messageArr[indexPath.row].massageId).removeValue()
                messageArr.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
               
                
            }
        }
    }}


extension UIImageView {
    
    // Downloads image from Cloud
    func loadFromUrl (url: String?) {
        
        guard let url = url else { return }
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, _) in
            guard let data = data else { return }
            let imageFromCloud = UIImage(data: data)
            self.image = imageFromCloud
        }
    }
}
