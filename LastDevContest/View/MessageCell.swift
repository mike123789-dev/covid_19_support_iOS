//
//  MessageCell.swift
//  LastDevContest
//
//  Created by 강병민 on 2020/07/25.
//  Copyright © 2020 강병민. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
