//
//  SettingControllerDelegate.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 1/8/17.
//  Copyright © 2017 Nguyen Quang Ngoc Tan. All rights reserved.
//

import Foundation

protocol SettingControllerDelegate {
    func updateTheme(_ value: Bool)
    func updatePercentSetting(percentUpdate: Int, position: Int)
}
