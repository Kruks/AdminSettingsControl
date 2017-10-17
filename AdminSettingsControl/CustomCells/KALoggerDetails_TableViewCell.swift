//
//  KALoggerDetails_TableViewCell.swift
//  LAFDBrush
//
//  Created by Nehru on 12/29/16.
//  Copyright © 2016 Kahuna Systems Pvt. Ltd. All rights reserved.
//

import UIKit

class KALoggerDetails_TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
