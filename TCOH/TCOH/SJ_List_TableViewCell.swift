//
//  SJ_List_TableViewCell.swift
//  TCOH
//
//  Created by student on 11/28/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class SJ_List_TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var SJ_id: UILabel!
    @IBOutlet weak var SJ_sec: UILabel!
    @IBOutlet weak var SJ_room: UILabel!
    @IBOutlet weak var SJ_time: UILabel!
   
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
