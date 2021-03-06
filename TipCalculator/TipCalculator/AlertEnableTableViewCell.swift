//
//  AlertEnableTableViewCell.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 1/22/17.
//  Copyright © 2017 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit

class AlertEnableTableViewCell: UITableViewCell {
    var settingController: SettingControllerDelegate? = nil
    //View references
    @IBOutlet weak var switchAlert: UISwitch!
    
    @IBAction func switchValueChange(_ sender: UISwitch) {
        settingController?.updateAlertSwitch(value: sender.isOn)
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
