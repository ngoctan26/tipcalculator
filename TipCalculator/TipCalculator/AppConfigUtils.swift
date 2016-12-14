//
//  AppConfigUtils.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 12/11/16.
//  Copyright © 2016 Nguyen Quang Ngoc Tan. All rights reserved.
//

import Foundation

class AppConfigUtils {
    static func loadSetting(key: String) -> Any {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key) as Any
    }
    
    static func saveSetting(configurations: [String : Any]) {
        let defaults = UserDefaults.standard
        for (key, object) in configurations {
            defaults.set(object, forKey: key)
        }
        defaults.synchronize()
    }
}
