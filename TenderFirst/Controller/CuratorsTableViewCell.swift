//
//  CuratorsTableViewCell.swift
//  TenderFirst
//
//  Created by Kuanysh on 25.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit

class CuratorsTableViewCell: UITableViewCell {

    @IBOutlet weak var curatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        curatorImageView.layer.borderWidth = 0
        curatorImageView.layer.masksToBounds = false
        curatorImageView.layer.borderColor = UIColor.black.cgColor
        curatorImageView.layer.cornerRadius = curatorImageView.frame.height/2
        curatorImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
