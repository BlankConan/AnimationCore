//
//  DedicatedLayerTVC.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/27.
//  Copyright © 2018 liu gangyi. All rights reserved.
//

import UIKit

class DedicatedLayerTVC: UITableViewController {

    let cells: [String] = {
        let arr = ["CAShapeLayer", "CATextLayer", "CATransformLayer",
                   "CAGradientLayer", "CAReplicatorLayer", "CAScrollLayer",
                   "CATiledLayer", "CAEmiterLayer", "CAEAGLLayer", "AVPlayerLayer"]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = cells[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DedicatedDetailVC(layerName: cells[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
