
//
//  LayerVCTableViewController.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/26.
//  Copyright © 2018 liu gangyi. All rights reserved.
//

import UIKit

class LayerVCTableViewController: UITableViewController {

    var sections: [Array<String>] = [Array<String>]()
    var headerTitles: [String] = ["寄宿图", "图层几何学","变换", "专用图层"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //   self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let oneSection = sections[section]
        return oneSection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let section = sections[indexPath.section]
        cell.textLabel?.text = section[indexPath.row]

        return cell
    }


}
