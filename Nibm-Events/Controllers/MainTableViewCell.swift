//
//  MainTableViewCell.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 3/1/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var EventName: UILabel!
    
    @IBOutlet weak var EventPost: UIImageView!
    
    @IBOutlet weak var DescriptionLable: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
