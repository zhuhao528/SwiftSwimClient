//
//  MyCourseTableViewController.swift
//  swim
//
//  Created by qing class on 2017/6/13.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit
import MJRefresh

class MyCourseTableViewController: UITableViewController {
    
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    var Courses: [CourseModel] = []
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
        CourseRequest(start: {
        }, success: { (courses) in
            DispatchQueue.main.async {
                self.Courses = Array(courses as! [CourseModel])
                if self.Courses.count < 10{self.footer.isHidden = true}
                else{self.footer.isHidden = false}
                self.tableView.reloadData()
                self.header.endRefreshing()
            }
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
                self.header.endRefreshing()
            }
        }.fetchUserCourseList(page:page,pageSize:10)
    }
    
    func footerRefresh(){
        page+=1
        CourseRequest(start: {
        }, success: { (courses) in
            DispatchQueue.main.async {
                self.Courses += courses as! [CourseModel]
                self.tableView.reloadData()
                self.footer.endRefreshing()
                Tools.showTap(message: "提交成功", superVC: self)
            }
            
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
                self.footer.endRefreshing()
            }
        }.fetchUserCourseList(page:page,pageSize:10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Courses.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Course", for: indexPath) as! CourseCell
        let course = Courses[indexPath.row] as CourseModel
        cell.TeacherNameLabel.text = course.TeacherName
        switch course.CourseType! {
        case .Theory:
            cell.CourseTypeLabel.text = "课程类型：理论"
        default:
            cell.CourseTypeLabel.text = "课程类型：泳池"
        }
        switch course.CourseStatus! {
        case .Order:
            cell.CousreStatusLabel.text = "审核中"
        case .Reject:
            cell.CousreStatusLabel.text = "驳回"
        default:
            cell.CousreStatusLabel.text = "已通过"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.StudentsNumberLabel.text = "学生人数："+String(course.StudentsNumber!)+"人"
        cell.SchoolTimeLabel.text =  "上课时间："+formatter.string(from:course.SchoolDate!)+" "+course.SchoolTime!
        cell.StudentsNamesLabel.text = "学生："+course.StudentsNames!
        return cell
    }
}
