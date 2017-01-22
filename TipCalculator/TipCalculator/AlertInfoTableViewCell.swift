//
//  AlertInfoTableViewCell.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 1/22/17.
//  Copyright © 2017 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit

class AlertInfoTableViewCell: UITableViewCell, UITextFieldDelegate {
    var settingController: SettingControllerDelegate? = nil
    // View references
    @IBOutlet weak var inputLimitationTextField: UITextField! {
        didSet {
            inputLimitationTextField.keyboardType = UIKeyboardType.numberPad
            inputLimitationTextField.delegate = self
            inputLimitationTextField.addTarget(self, action: #selector(self.onTextChange(textField:)), for: UIControlEvents.editingChanged)
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
            let updateText = textField.text!
            settingController?.updateAlertInfo(value: updateText)
        }
    }
}
