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
    var images: [imagearry] =  [imagearry (img: UIImage(named: "basketball")!, imageName: "Basketball"),
                                imagearry (img: UIImage(named: "pinting3")! , imageName: "Pinting"),
                                imagearry (img: UIImage(named: "skate")! , imageName: "Skating"),
                                imagearry (img: UIImage(named: "volly")! , imageName: "Vollyball"),
                                imagearry (img: UIImage(named: "cycle2")! , imageName: "Cycling"),
                                imagearry (img: UIImage(named: "music")! , imageName: "Music"),
                                imagearry (img: UIImage(named: "hiking3")! , imageName: "Hiking")]
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: collectionView.frame.size.width/9, height: collectionView.frame.size.height/9)
//
//    }

    


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
//       cell.decrip.titleLabel!.text = images[indexPath.row].imageName
        cell.decrip.tag = indexPath.row
        cell.decrip.setTitle(images[indexPath.row].imageName, for: .normal)
        cell.decrip.addTarget(self, action: #selector(descript), for: .touchUpInside)
        cell.hobbyImage.image = images[indexPath.row].img
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
  
    
    @IBOutlet weak var collection: UICollectionView!
    
    
  
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
                let data = snapshot.documents[0].data()
                let city = data["city"] as! String
                
                SP.cityName = city
                print(city)
            }
        
        navigationController?.pushViewController(SP, animated: true)
    }
    
    @IBAction func updatButton(_ sender: Any) {
        guard let SP = storyboard?.instantiateViewController(identifier: "Updating") as? Updating else {
    
            return
        }
        navigationController?.pushViewController(SP, animated: true)
    }
    
    
      
       
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(UINib(nibName: "CollectionCell",bundle:nil), forCellWithReuseIdentifier: "CollectionCell")

//        sportImages.append(UIImage(data: <#T##Data#>)) 
        

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

//    move to screen (for index) {
    
    
    
    
}
