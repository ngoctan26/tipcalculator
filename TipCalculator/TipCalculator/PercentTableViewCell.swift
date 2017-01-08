//
//  PercentTableViewCell.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 12/31/16.
//  Copyright © 2016 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit

class PercentTableViewCell: UITableViewCell, UITextFieldDelegate {
    var settingController: SettingControllerDelegate? = nil
    var position: Int = 0
    
    // View references
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var inputPercentTextField: UITextField!{
        didSet{
            inputPercentTextField.keyboardType = UIKeyboardType.numberPad
            inputPercentTextField.delegate = self
            inputPercentTextField.addTarget(self, action: #selector(self.onTextChange(textField:)), for: UIControlEvents.editingChanged)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onTextChange(textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            settingController?.updatePercentSetting(percentUpdate: Int(textField.text!)!, position: position)
        }
    }
}
