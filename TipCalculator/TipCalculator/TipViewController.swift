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
    var alertController: UIAlertController = UIAlertController()
    
    @IBAction func onSegButtonClicked(_ sender: Any) {
        updateScreen()
    }
    
    // Mark: properties
    var tipPercents: [Int] = Setting.PERCENT_SETTING_DEFAULT_VALUE
    let bilMaxLength = 9
    var isAlertEnable = false
    var alertLimiation = Setting.ALERT_LIMIATION_DEFAULT_VALUE
    
    // Mark: actions
    @IBAction func unwindTipView(sender: UIStoryboardSegue) {
        if sender.source is SettingViewController {
            updateSetting()
            updateScreen()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMoveBackToForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        initView()
        initAlertController()
        updateScreen()
        updateHistoryValueToScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        // Always show numpad
        self.textFieldInputBill.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func appMovedToBackground(_ notification: NSNotification) {
        print("application go to background")
        var saveValue: [String : Any] = [:]
        saveValue[Setting.DATE_STORE_KEY] = Date()
        saveValue[Setting.HISTORY_VALUE_KEY] = textFieldInputBill.text
        AppConfigUtils.saveSetting(configurations: saveValue)
    }

    func appMoveBackToForeground(_ notification: NSNotification) {
        updateHistoryValueToScreen()
    }

    func updateHistoryValueToScreen() {
        let currentDate = Date()
        let previousDate = AppConfigUtils.loadSetting(key: Setting.DATE_STORE_KEY, defaultValue: nil)
        if previousDate != nil {
            var prDate = previousDate as! Date
            prDate = prDate.addingTimeInterval(10 * 60)
            if prDate.compare(currentDate) == ComparisonResult.orderedAscending {
                textFieldInputBill.text = "0"
            } else {
                let previousValue = AppConfigUtils.loadSetting(key: Setting.HISTORY_VALUE_KEY, defaultValue: "0")
                textFieldInputBill.text = previousValue as! String?
            }
            updateScreen()
        }
    }
    
    func updateSetting() {
        let isDarkTheme = AppConfigUtils.loadSetting(key: Setting.THEME_SETTING_KEY, defaultValue: false) as! Bool
        self.view.backgroundColor = isDarkTheme ? Setting.DARK_COLOR : Setting.BRIGHT_COLOR
        tipPercents = AppConfigUtils.loadSetting(key: Setting.PERCENT_SETTING_KEY, defaultValue: Setting.PERCENT_SETTING_DEFAULT_VALUE) as! [Int]
        for i in 0...2 {
            segButtonTipPercent.setTitle(String(tipPercents[i]) + "%", forSegmentAt: i)
        }
        isAlertEnable = AppConfigUtils.loadSetting(key: Setting.ALERT_ENABLE_KEY, defaultValue: false) as! Bool
        alertLimiation = AppConfigUtils.loadSetting(key: Setting.ALERT_LIMITATION_KEY, defaultValue: Setting.ALERT_LIMIATION_DEFAULT_VALUE) as! Int
    }

    func initView() {
        // Load settings
        updateSetting()
        textFieldInputBill.text = formatNormalNumber(inputNum: 0)
        textFieldInputBill.becomeFirstResponder()
        // Set segment button title
        textFieldInputBill.keyboardType = UIKeyboardType.decimalPad
        // Set text field change listener
        textFieldInputBill.addTarget(self, action: #selector(onTextFieldChanged(textField:)), for: UIControlEvents.editingChanged)
    }

    func initAlertController() {
        alertController = UIAlertController(title: "Out of money", message: "Your tip is over the limitation.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
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
        // Handle input character is comma
        if !billInputText.isEmpty {
            let lastChar = billInputText.characters.last!
            if lastChar == "," || lastChar == "." {
                
                return
            }
        }
        
        // Update screen to 0 value whether current input value is empty
        hanldeAmountInput = billInputText.isEmpty ? "0" : billInputText
        // Update input textField format
        textFieldInputBill.text = formatNormalNumber(inputNum: formatNumberFromStr(inputStr: hanldeAmountInput))
        let billAmount: Float = formatNumberFromStr(inputStr: hanldeAmountInput)
        let selectedPercentIndex = segButtonTipPercent.selectedSegmentIndex
        let percent = Float(String(tipPercents[selectedPercentIndex]))
        let tipAmount = billAmount * percent! / 100
        let totalBill = tipAmount + billAmount
        // Show tip and total bill
        labelTipResult.text = formatCurrency(inputNum: tipAmount)
        labelTotalBill.text = formatCurrency(inputNum: totalBill)
        if isAlertEnable && tipAmount > Float(alertLimiation) {
            self.present(alertController, animated: true, completion: nil)
        }
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
    
    func formatNormalNumber(inputNum: Float) -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: inputNum))!
    }
    
    func formatNumberFromStr(inputStr: String) -> Float {
        let number = NumberFormatter().number(from: inputStr)
        if let number = number {
            return Float(number.stringValue)!
        }
        return 0.0
    }
    
}
