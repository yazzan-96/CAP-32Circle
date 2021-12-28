//
//  ImageCellTableViewCell.swift
//  Circle
//
//  Created by Yazan Alraddadi on 22/05/1443 AH.
//

import UIKit

class ImageCellTableViewCell: UITableViewCell , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var CameraVC = UIImagePickerController ()
    @IBOutlet weak var imageCell: UIImageView!
    
  
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


