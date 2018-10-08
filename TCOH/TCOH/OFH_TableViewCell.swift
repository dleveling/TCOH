//
//  OFH_TableViewCell.swift
//  TCOH
//
//  Created by student on 12/14/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class OFH_TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dayOFH: UILabel!
    @IBOutlet weak var timeOFH: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
