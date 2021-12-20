//
//  ChatTableCell.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import UIKit

class ChatTableCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var msgView: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        msgView.layer.cornerRadius = 25
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
    

}
