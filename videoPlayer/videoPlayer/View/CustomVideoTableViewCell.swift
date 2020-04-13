//
//  CustomVideoTableViewCell.swift
//  videoPlayer
//
//  Created by Çağrı Tuğberk Masat on 14.04.2020.
//  Copyright © 2020 Çağrı Tuğberk Masat. All rights reserved.
//

import UIKit

class CustomVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customCellView: UIView!
    @IBOutlet weak var customCellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCellView.layer.cornerRadius = customCellView.frame.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
