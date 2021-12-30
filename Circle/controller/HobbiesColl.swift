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
    
     var hobbyDescription: [String] = ["Basketball is a game played between two teams of five players each on a rectangular court, usually indoors. Each team tries to score by tossing the ball through the opponent's goal, an elevated horizontal hoop and net called a basket","Painting, the expression of ideas and emotions, with the creation of certain aesthetic qualities, in a two-dimensional visual language. The elements of this language—its shapes, lines, colours, tones, and textures—are used in various ways to produce sensations of volume, space, movement, and light on a flat surface" , "saS"]

    var sportImages : [UIImage] = []
    var images: [imagearry] =  [imagearry (img : UIImage(named: "basketball")!, imageName: "Basketball"),imagearry (img: UIImage(named: "pinting1")! , imageName: "pinting"),imagearry (img: UIImage(named: "skate2")! , imageName: "skate"),imagearry (img: UIImage(named: "volly")! , imageName: "volly"),imagearry (img: UIImage(named: "stringart1")! , imageName: "stringart"),imagearry (img: UIImage(named: "music")! , imageName: "music"),imagearry (img: UIImage(named: "hiking3")! , imageName: "hiking")]
    
    
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
//        cell.hobbyname.tag = indexPath.row
//        cell.description.tag = indexPath.row
        cell.decrip.titleLabel!.text = images[indexPath.row].imageName
        cell.decrip.tag = indexPath.row
        cell.decrip.addTarget(self, action: #selector(descript), for: .touchUpInside)
        cell.hobbyImage.image = images[indexPath.row].img
        cell.heightConst.constant = 650
        cell.widthConst.constant = 450
        print(images.count)
        return cell
    }
    @objc func descript (sender : UIButton) {
        let indexpath = IndexPath (row: sender.tag, section: 0)
        let cell = images[indexpath.row].imageName
        let cell2 = hobbyDescription[indexpath.row]
        
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
