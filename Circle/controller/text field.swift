//
//  text field.swift
//  Circle
//
//  Created by Yazan Alraddadi on 10/06/1443 AH.
//

import Foundation
import UIKit
class customField  : UITextField {
    override init (frame: CGRect){
        super.init(frame: frame)
    }
required public init? (coder aDecoder :NSCoder) {
    super.init (coder : aDecoder)
}
}
func commoninit() {
    self.placeHolderColor = UIColor.white
}
var placeHolderColor : UIColor = UIColor.lightGray{
    didSet {
        self.setPlaceholderColor()
    }
}
private func setPlaceholderColor () {
    self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "" ,attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor)
}
