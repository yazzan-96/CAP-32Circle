//
//  CollectionCell.swift
//  Circle
//
//  Created by Yazan Alraddadi on 09/05/1443 AH.
//

import UIKit
//struct Urlimages {
//    let urlImages = ["https://firebasestorage.googleapis.com/v0/b/circle-c51f8.appspot.com/o/8ball.jpeg?alt=media&token=9f33517b-6231-4cbe-b22f-5cabef59533f", "https://firebasestorage.googleapis.com/v0/b/circle-c51f8.appspot.com/o/images%2Fbasketball.jpeg?alt=media&token=ff971b72-278b-4be8-8061-9bad5ed53104" ]
    
//}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var event: UIButton!
    
    @IBOutlet weak var hobbyImage: UIImageView!
    
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var widthConst: NSLayoutConstraint!

    @IBOutlet weak var events: UIButton!
    
    @IBOutlet weak var decrip: UIButton!
    
    
    

    
//    @IBAction func hobbyname(_ sender: UIButton) {
//        
//        
//        
        
//        print(sender.tag)
//        move to screen (sender.tag)
        
       
////    hockey
//                            
//        
//        }}
//    @IBOutlet weak var habbyName: UIButton!
//    
    
    func downloadFilesFromStore  () {
        let imageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/circle-c51f8.appspot.com/o/8ball.jpeg?alt=media&token=9f33517b-6231-4cbe-b22f-5cabef59533f")
        URLSession.shared.dataTask(with: imageURL!) { (data, _, error) in
            
            if (error == nil) {
                guard let data = data
                else { return }
                
                DispatchQueue.main.async {
                    self.hobbyImage.image = UIImage (data: data)
                }
            }
        }
                       
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
