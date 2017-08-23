//
//  ManageAccountListTableViewController.swift
//  swim
//
//  Created by qing class on 2017/7/13.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit
import MJRefresh

class ManageAccountListTableViewController: UITableViewController,AccountCellDelegate {

    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    var models: [UserModel] = []
    var page:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.setRefreshingTarget(self, refreshingAction: #selector(MyCourseTableViewController.headerRefresh))
        self.tableView.tableHeaderView = header
        footer.setRefreshingTarget(self, refreshingAction: #selector(MyCourseTableViewController.footerRefresh))
        self.tableView.tableFooterView = footer
        footer.isHidden = true
    }
    
    func headerRefresh(){
        page = 0;
        UserInfoRequest(start: {
        }, success: { (courses) in
            DispatchQueue.main.async {
                self.models = Array(courses as! [UserModel])
                if self.models.count < 10{self.footer.isHidden = true}
                else{self.footer.isHidden = false}
                self.tableView.reloadData()
                self.header.endRefreshing()
            }
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
                self.header.endRefreshing()
            }
        }.fetchUserList(page:page,pageSize:10)
    }
    
    func footerRefresh(){
        page+=1
        UserInfoRequest(start: {
        }, success: { (courses) in
            DispatchQueue.main.async {
                self.models += courses as! [UserModel]
                self.tableView.reloadData()
                self.footer.endRefreshing()
                Tools.showTap(message: "提交成功", superVC: self)
            }
            
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
                self.footer.endRefreshing()
            }
        }.fetchUserList(page:page,pageSize:10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageAccountCell", for: indexPath) as! AccountCell
        cell.cellDelegate = self
        cell.tag = indexPath.row
        let model:UserModel = models[indexPath.row]
        cell.TeacherNameLabel.text = model.userName
        cell.AccountLabel.text = model.account
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.CreateTimeLabel.text = formatter.string(from:model.regestTime!)
        if model.authority == .Manage {
            cell.DeleteAccountButton.isHidden = true
        }else{
            cell.DeleteAccountButton.isHidden = false
        }
        return cell
    }
    
    // 修改密码
    func changePasswordPressed(_ tag: Int){
        let model:UserModel = models[tag]
        guard let vc = UIStoryboard.init(name: "ManageAccount", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateAccount") as? CreateAccountViewController  else {
            return
        }
        vc.userInfo = model
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    // 删除账号
    func deleteAccountPressed(_ tag: Int){
        let model:UserModel = models[tag]
        UserInfoRequest(start: {
        }, success: { (result) in
            DispatchQueue.main.async {
                Tools.showTap(message:"删除成功", superVC: self)
            }
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
            }
        }.accountDelete(userId: model.userId!)
    }
}
