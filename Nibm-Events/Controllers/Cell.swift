//
//  Cell.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 3/1/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import Foundation
import  UIKit

class Cell{
    
    var EventImg : UIImage
    var EventTitle: String
    var EventDesc: String
    
    
    init(EventImg: UIImage , EventTitle:String , EventDesc:String ) {
        
        self.EventImg = EventImg
        self.EventTitle = EventTitle
        self.EventDesc = EventDesc
        
    }
}
