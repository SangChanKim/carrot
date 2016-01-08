//
//  topThreeTableViewCell.swift
//  Carrot
//
//  Created by Kevin Kim on 1/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit

class topThreeTableViewCell: UITableViewCell {

    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
