//
//  Setting.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 1/2/17.
//  Copyright © 2017 Nguyen Quang Ngoc Tan. All rights reserved.
//

import Foundation
import UIKit

class Setting {
    static let THEME_SETTING_KEY = "dark_theme"
    static let THEME_SETTING_DEFAULT_VALUE = false
    static let PERCENT_SETTING_KEY = "percent_value"
    static let PERCENT_SETTING_DEFAULT_VALUE = [15, 20, 25]
    static let INPUT_CALCULATE_STORED_KEY = "stored_calculation"
    static let INPUT_CALCULATE_STORED_DEFAULT_VALUE = 0
    static let DARK_COLOR = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
    static let BRIGHT_COLOR = UIColor.white
    static let DATE_STORE_KEY = "save-time"
    static let HISTORY_VALUE_KEY = "history-value"
    static let ALERT_ENABLE_KEY = "alert_enable"
    static let ALERT_LIMITATION_KEY = "alert_value"
    static let ALERT_LIMIATION_DEFAULT_VALUE = 999999999
}
