//
//  MyCourseTableViewController.swift
//  swim
//
//  Created by qing class on 2017/6/13.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit
import MJRefresh

class ManageAccountHomeTableViewController: UITableViewController {
    
    var content: [String] = ["新建帐号","管理账号"]
    let ID = "AccountHomeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath)
        cell.textLabel?.text = content[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = UIStoryboard.init(name: "ManageAccount", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateAccount")
            self.navigationController!.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "ManageAccount", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageAccountList")
            vc.title = "账号列表"
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}
