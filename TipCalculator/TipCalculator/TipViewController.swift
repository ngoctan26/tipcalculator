//
//  TipViewController.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 12/11/16.
//  Copyright © 2016 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    // Views references
    @IBOutlet weak var textFieldInputBill: UITextField!
    @IBOutlet weak var labelTipResult: UILabel!
    @IBOutlet weak var labelTotalBill: UILabel!
    @IBOutlet weak var segButtonTipPercent: UISegmentedControl!
    
    @IBAction func onSegButtonClicked(_ sender: Any) {
        updateScreen()
    }
    
    // Mark: properties
    var tipPercents: [Int] = Setting.PERCENT_SETTING_DEFAULT_VALUE
    let bilMaxLength = 9
    
    // Mark: actions
    @IBAction func unwindTipView(sender: UIStoryboardSegue) {
        if sender.source is SettingViewController {
            updateSetting()
            updateScreen()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        updateScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        // Always show numpad
        self.textFieldInputBill.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSetting() {
        let isDarkTheme = AppConfigUtils.loadSetting(key: Setting.THEME_SETTING_KEY, defaultValue: false) as! Bool
        self.view.backgroundColor = isDarkTheme ? Setting.DARK_COLOR : Setting.BRIGHT_COLOR
        tipPercents = AppConfigUtils.loadSetting(key: Setting.PERCENT_SETTING_KEY, defaultValue: Setting.PERCENT_SETTING_DEFAULT_VALUE) as! [Int]
        for i in 0...2 {
            segButtonTipPercent.setTitle(String(tipPercents[i]) + "%", forSegmentAt: i)
        }
    }

    func initView() {
        // Load settings
        updateSetting()
        textFieldInputBill.text = formatNormalNumber(inputNum: 0)
        // Set segment button title
        textFieldInputBill.keyboardType = UIKeyboardType.numberPad
        // Set text field change listener
        textFieldInputBill.addTarget(self, action: #selector(onTextFieldChanged(textField:)), for: UIControlEvents.editingChanged)
    }

    func onTextFieldChanged(textField: UITextField) {
        if (textField.text?.characters.count)! > 9 {
            // Adjust max length of textField
            textField.deleteBackward()
            return
        }
        updateScreen()
    }

    func updateScreen() {
        var hanldeAmountInput = "0"
        guard let billInputText = textFieldInputBill.text else {
            return
        }
        // Update screen to 0 value whether current input value is empty
        hanldeAmountInput = billInputText.isEmpty ? "0" : billInputText
        // Update input textField format
        textFieldInputBill.text = formatNormalNumber(inputNum: Int(hanldeAmountInput)!)
        let billAmount: Float = Float(hanldeAmountInput)!
        let selectedPercentIndex = segButtonTipPercent.selectedSegmentIndex
        let percent = Float(String(tipPercents[selectedPercentIndex]))
        let tipAmount = billAmount * percent! / 100
        let totalBill = tipAmount + billAmount
        // Show tip and total bill
        labelTipResult.text = formatCurrency(inputNum: tipAmount)
        labelTotalBill.text = formatCurrency(inputNum: totalBill)
    }

    func formatCurrency(inputNum: Float) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: inputNum))!
    }
    
    func formatNormalNumber(inputNum: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 0
        return formatter.string(from: NSNumber(value: inputNum))!
    }
}
