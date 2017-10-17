//
//  ServerURL_TableViewCell.swift
//  LAFDBrush
//
//  Created by Nehru on 12/29/16.
//  Copyright © 2016 Kahuna Systems Pvt. Ltd. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ServerURL_TableViewCell: UITableViewCell {

    @IBOutlet weak var serverURLTextField: SkyFloatingLabelTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let commonConfig = CommonConfigurationClass.sharedInstance
//        commonConfig.applyAppThemeToFloatingTextField(self.ServerURLTextField)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
