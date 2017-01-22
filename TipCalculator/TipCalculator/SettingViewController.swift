//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 12/11/16.
//  Copyright © 2016 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController, SettingControllerDelegate {
    // Mark properties
    let THEM_CELL_REUSE_IDENTIFIER = "themeCell"
    let PERCENT_CELL_REUSE_IDENTIFIER = "percentCell"
    let SECTION_HEADERS = ["Theme", "Percent", "Alert"]
    var isThemeDarkEnable = Setting.THEME_SETTING_DEFAULT_VALUE
    let percentOptionLabel = ["Option 1", "Option 2", "Option 3"]
    var percentValue = Setting.PERCENT_SETTING_DEFAULT_VALUE
    
    // View references
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    

    // Button action reference
    @IBAction func cancelButtonClicked(_ sender: Any) {
        destroyCurrentView()
    }
    
    func destroyCurrentView() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === doneBtn else {
            // It is not done button, just return
            return
        }
        // Save current setting
        AppConfigUtils.saveSetting(configurations: getCurrentSetting())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get previous setting
        loadPreviousSettingToView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SECTION_HEADERS.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SECTION_HEADERS[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowInSection = 0
        switch section {
        case 0:
            rowInSection = 1
        case 1:
            rowInSection = 3
        case 2:
            rowInSection = 2
        default:
            rowInSection = 0
        }
        return rowInSection
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        switch indexPath.section {
        case 0:
            cellHeight = 60.0
        default:
            cellHeight = 60.0
        }
        return cellHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier:  THEM_CELL_REUSE_IDENTIFIER, for: indexPath) as! SettingThemeTableViewCell
            cell.settingController = self
            cell.swithTheme.setOn(isThemeDarkEnable, animated: false)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:  PERCENT_CELL_REUSE_IDENTIFIER, for: indexPath) as! PercentTableViewCell
            cell.settingController = self
            cell.position = indexPath.row
            cell.optionLabel.text = percentOptionLabel[indexPath.row]
            cell.inputPercentTextField.text = String(percentValue[indexPath.row])
            return cell
        
            
        default:
            return UITableViewCell()
        }
    }
    
    func loadPreviousSettingToView() {
        isThemeDarkEnable = AppConfigUtils.loadSetting(key: "dark_theme", defaultValue: Setting.THEME_SETTING_DEFAULT_VALUE) as! Bool
        self.view.backgroundColor = isThemeDarkEnable ? Setting.DARK_COLOR : Setting.BRIGHT_COLOR
        percentValue = AppConfigUtils.loadSetting(key: "percent_value", defaultValue: Setting.PERCENT_SETTING_DEFAULT_VALUE) as! [Int]
    }
    
    func getCurrentSetting() -> [String : Any] {
        var configurations: [String : Any] = [:]
        configurations[Setting.THEME_SETTING_KEY] = isThemeDarkEnable
        configurations[Setting.PERCENT_SETTING_KEY] = percentValue
        return configurations
    }
    
    func updateTheme(_ value: Bool) {
        isThemeDarkEnable = value
        self.view.backgroundColor = isThemeDarkEnable ? Setting.DARK_COLOR : Setting.BRIGHT_COLOR
    }
    
    func updatePercentSetting(percentUpdate: Int, position: Int) {
        percentValue[position] = percentUpdate
    }
}
