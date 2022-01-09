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
    
    var hobbyDescription: [String] = ["Basketball is a game played between two teams of five players each on a rectangular court, usually indoors. Each team tries to score by tossing the ball through the opponent's goal, an elevated horizontal hoop and net called a basket","Painting is the practice of applying paint, pigment, color or other medium to a solid surface" , "skating, sport in which bladelike runners or sets of wheels attached to shoes are used for gliding on ice or other surfaces","Volleyball is a team sport in which two teams of six players are separated by a net. Each team tries to score points by grounding a ball on the other team's court under organized rules","Cycle sport is competitive physical activity using bicycles","Community music involves musicians working with people to enable them to actively enjoy and participate in music","hiking, walking in nature as a recreational activity"]
    
    var sportImages : [UIImage] = []
    var images: [imagearry] =  [imagearry (img: UIImage(named: "baskeet")!, imageName: "Basketball"),
                                imagearry (img: UIImage(named: "pinting3")! , imageName: "Pinting"),
                                imagearry (img: UIImage(named: "skate")! , imageName: "Skating"),
                                imagearry (img: UIImage(named: "volly")! , imageName: "Vollyball"),
                                imagearry (img: UIImage(named: "cycle2")! , imageName: "Cycling"),
                                imagearry (img: UIImage(named: "music")! , imageName: "Music"),
                                imagearry (img: UIImage(named: "hiking3")! , imageName: "Hiking"),
                                imagearry (img: UIImage(named: "photography")! , imageName: "Photography"),
                                imagearry (img: UIImage(named: "sven-kucinic-Z0KjmjxUsKs-unsplash-min (2) (1) (1)")! , imageName: "Photography")]
    
    
    
    
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
        cell.events.tag = indexPath.row
        cell.events.addTarget(self, action: #selector(eventButt), for: .touchUpInside)
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
    
    @objc func eventButt (sender : UIButton) {
        var indexpath = IndexPath (row: sender.tag, section: 0)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventsTable") as! EventsTable
        self.navigationController?.pushViewController(vc, animated: true)
        
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
