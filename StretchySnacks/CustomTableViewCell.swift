//
//  CustomTableViewCell.swift
//  StretchySnacks
//
//  Created by Eric Gregor on 2018-03-01.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var snackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
