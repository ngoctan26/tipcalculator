//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Nguyen Quang Ngoc Tan on 12/11/16.
//  Copyright © 2016 Nguyen Quang Ngoc Tan. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    // Mark properties
    let SECTION_HEADERS = ["Percent", "Theme"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            rowInSection = 3
        case 1:
            rowInSection = 1
        default:
            rowInSection = 0
        }
        return rowInSection
    }

    
}
