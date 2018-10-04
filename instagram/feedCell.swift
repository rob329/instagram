//
//  feedCell.swift
//  instagram
//
//  Created by Robert Bolt on 10/2/18.
//  Copyright © 2018 Robert Bolt. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
