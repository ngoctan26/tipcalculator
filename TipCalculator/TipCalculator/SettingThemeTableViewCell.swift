//
//  SettingThemeTableViewCell.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 12/31/16.
//  Copyright © 2016 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit

class SettingThemeTableViewCell: UITableViewCell {
    var settingController: SettingControllerDelegate? = nil
    @IBOutlet weak var swithTheme: UISwitch!
    
    // View references
    @IBAction func onSwitchChangeValue(_ sender: UISwitch) {
        settingController?.updateTheme(sender.isOn)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
