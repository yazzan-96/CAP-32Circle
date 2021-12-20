//
//  HobbiesColl.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit
import FirebaseAuth
struct imagearry {
    var img : UIImage
    var imageName : String
    
}
class HobbiesColl: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    var sportImages : [UIImage] = []
    var images: [imagearry] =  [imagearry (img : UIImage(named: "basketball")!, imageName: "Basketball"),imagearry (img: UIImage(named: "8ball")! , imageName: "8ball")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
//        cell.habbyName.setTitle(images[indexPath.row].imageName, for: .normal)
//        cell.hobbyname.setTitle(images[indexPath.row].imageName, for: .normal)
//        cell.hobbyname.tag = indexPath.row
//        cell.habbyName.tag = indexPath.row
        cell.hobbyImage.image = images[indexPath.row].img
        print(images.count)
        return cell
    }
    
  

    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let SP = storyboard?.instantiateViewController(identifier: "Chat") as? Chat else {
    
            return
        }
        SP.groupName = images[indexPath.row].imageName
        
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
