//
//  Assist_TableViewCell.swift
//  TCOH
//
//  Created by student on 11/29/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class Assist_TableViewCell: UITableViewCell {
    
    

 
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var stuName: UILabel!
    @IBOutlet weak var stuID: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
