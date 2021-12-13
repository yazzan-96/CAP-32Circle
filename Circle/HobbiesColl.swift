//
//  HobbiesColl.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit

class HobbiesColl: UIViewController {
    
//    let image : []
    
   
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    var images: [UIImage] = []
    
    
    

    

    @IBAction func test(_ sender: Any) {
    }
    @IBAction func LogOutButton(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! Login
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collection.delegate = self
//        collection.dataSource = self
        
        collection.register(UINib(nibName: "CollectionCell",bundle:nil), forCellWithReuseIdentifier: "CollectionCell")

        
        

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
