//
//  HobbiesColl.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

struct imagearry {
    var img : UIImage
    var imageName : String
    
}
class HobbiesColl: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    var hobbyDescription: [String] = ["Basketball is a game played between two teams of five players each on a rectangular court. Each team tries to score by tossing the ball through the opponent’s goal, horizontal hoop and net called a basket.",
                                      
                                      " A painting is a artwork created using  color on a surface such as paper or canvas. The pigment may be in a wet form, such as paint, or a dry form, such as pastels " ,
                                      
                                      "any sports or recreational activity which consists of traveling on surfaces or on ice using skates",
                                      
                                      " Volleyball is two teams of 6 players separated by a net. every team tries to score points by grounding a ball on the other team's court under organized rules",
                                      
                                      " It makes people gather to ride a bike for whatever purpose they choose. The program connects individuals with the community to build social networks, feel comfortable and enjoy being active through cycling",
                                      
                                      "Meet with other local music enthusiasts! Gather for socializing, meet new people and, of course, listen to music!",
                                      
                                      "Hiking is walking in natural environments, often in mountainous terrain or other scenic terrain.",
                                      
                                      "This community will help connect photographers to share their tips and photos.",
                                      
                                      "Crochet is the process of creating textiles by using a crochet hook to connect loops of thread, yarn, or threads of other materials"]
    var sportImages : [UIImage] = []
    var images: [imagearry] =  [imagearry (img: UIImage(named: "basketball")!, imageName: "Basketball"),
                                imagearry (img: UIImage(named: "painting5")! , imageName: "Painting"),
                                imagearry (img: UIImage(named: "skating5")! , imageName: "Skating"),
                                imagearry (img: UIImage(named: "vollyball5")! , imageName: "Vollyball"),
                                imagearry (img: UIImage(named: "cycling")! , imageName: "Cycling"),
                                imagearry (img: UIImage(named: "music5")! , imageName: "Music"),
                                imagearry (img: UIImage(named: "hiking5")! , imageName: "Hiking"),
                                imagearry (img: UIImage(named: "photography5")! , imageName: "Photography"),
                                imagearry (img: UIImage(named: "Crochet-1")! , imageName: "Crochet")]
    
    
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        //        cell.descripsion = print(images[indexPath.row].imageName)
        //        cell.habbyName.setTitle(images[indexPath.row].imageName, for: .normal)
        //        cell.hobbyname.setTitle(images[indexPath.row].imageName, for: .normal)
        //       cell.hobbyname.tag = indexPath.row
        //        cell.description.tag = indexPath.row
//        cell.titleLabel.text = images[indexPath.row].imageName
//        cell.events.tag = indexPath.row
//        cell.events.addTarget(self, action: #selector(eventButt), for: .touchUpInside)
        cell.decrip.tag = indexPath.row
//        cell.events
        //        cell.decrip.setTitle(images[indexPath.row].imageName, for: .normal)
        cell.decrip.addTarget(self, action: #selector(descript), for: .touchUpInside)
        cell.hobbyImage.image = images[indexPath.row].img
        //        cell.decrip.titleLabel?.font =  UIFont(name: "Helvetica Neue", size: 30)
        cell.heightConst.constant = 650
        cell.widthConst.constant = 450
        print(images.count)
        return cell
    }
    
    
    
    @objc func descript (sender : UIButton) {
        
        var indexpath = IndexPath (row: sender.tag, section: 0)
        let cell = images[indexpath.item].imageName
        let cell2 = hobbyDescription[indexpath.item]
        // Create the alert controller
        let alertController = UIAlertController(title: cell, message: cell2, preferredStyle: .alert)
        
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let SP = storyboard?.instantiateViewController(identifier: "Chat") as? Chat else {
            
            return
        }
        SP.groupName = images[indexPath.row].imageName
        
        
        
        let refrence = Firestore.firestore().collection("users")
        refrence.whereField("id", isEqualTo: Auth.auth().currentUser?.uid)
            .getDocuments { snapshot, error in
                guard let snapshot = snapshot else {
                    return
                }
                if snapshot.documents.count > 0 {
                    let data = snapshot.documents[0].data()
                    let city = data["city"] as! String
                    
                    SP.cityName = city
                    print(city)
                }}
        
        navigationController?.pushViewController(SP, animated: true)
    }
    
    @IBAction func updatButton(_ sender: Any) {
        guard let SP = storyboard?.instantiateViewController(identifier: "Updating") as? Updating else {
            
            return
        }
        navigationController?.pushViewController(SP, animated: true)
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
        self.navigationItem.hidesBackButton = true
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(UINib(nibName: "CollectionCell",bundle:nil), forCellWithReuseIdentifier: "CollectionCell")
        
        
        
        
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
