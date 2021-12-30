//
//  Message.swift
//  Circle
//
//  Created by Yazan Alraddadi on 08/05/1443 AH.
//

import Foundation
import UIKit
import FirebaseFirestore
import Firebase

class Message {
    var sender = ""
    var msgBody : String? 
    var imgUrl : String?
    var type : Int = 0  // 0-Text 1-Image 2-Location 3-Contact 4-Audio
    var imgMsg : UIImage?
    var date : String = ""
    var userId : String = ""
    // msg id
    
}

