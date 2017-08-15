//
//  CourseRequest.swift
//  swim
//
//  Created by qing class on 2017/7/6.
//  Copyright © 2017年 qing class. All rights reserved.
//

import Foundation
import Alamofire


/// 教练课程请求
class CourseRequest: BaseRequest {
    
    /// 通过用户ID获取当前用户的课程列表
    ///
    /// - Parameter page: Int,pageSize:Int
    func fetchUserCourseList(page: Int,pageSize:Int){
        let requestPath = "\(RequestHome)\(RequestUserCourseList)"
        let parameters: Parameters = ["userId": AccountManager.share().userId,
                                      "page":page,
                                      "pageSize":pageSize]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseCourseModel>) in
                print(response)
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    let Courses:[CourseModel] = data.list!
                    self.success(Courses)
                case .failure(let error):
                    self.faile(error.localizedDescription)
                }
        }
    }
    

    // 添加笔记
    // - Parameter model: 笔记内容Model
    func CourseAdd(model: CourseModel) {
        let requestPath = "\(RequestHome)\(RequestCourseAdd)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let parameters: Parameters = ["userId": AccountManager.share().userId,
                                      "CourseType":  model.CourseType,
                                      "TeacherName": model.TeacherName!,
                                      "SchoolDate": dateFormatter.string(from:model.SchoolDate!),
                                      "SchoolTime": model.SchoolTime!,
                                      "StudentsNumber": model.StudentsNumber!,
                                      "StudentsNames": model.StudentsNames!,
                                      "CourseStatus": model.CourseStatus]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseCourseModel>) in
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    self.success(data.result ?? "提交成功")
                case .failure(let error):
                    self.faile(error.localizedDescription)
                }
        }
    }
}


/// 课程管理请求
class ManageCourseRequest: BaseRequest {
    
    /// 获取当前用户的课程列表
    /// 不展示已经驳回的课程
    /// - Parameter page: Int,pageSize:Int
    func fetchCourseList(page: Int,pageSize:Int){
        let requestPath = "\(RequestHome)\(RequestCourseList)"
        let parameters: Parameters = ["page":page,
                                      "pageSize":pageSize]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseCourseModel>) in
                print(response)
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    let Courses:[CourseModel] = data.list!
                    self.success(Courses)
                case .failure(let error):
                    self.faile(error.localizedDescription)
                }
        }
    }
    
    /// 导出报表
    ///
    /// From: To: Email:
    func exportForm(From: String,To:String,Email:String){
        let requestPath = "\(RequestHome)\(RequestExportForms)"
        let parameters: Parameters = ["From":From,
                                      "To":To,
                                      "Email":Email]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseCourseModel>) in
                print(response)
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    let Courses:[CourseModel] = data.list!
                    self.success(Courses)
                case .failure(let error):
                    self.faile(error.localizedDescription)
                }
        }
    }

    
    /// 通过课程ID更新课程状态
    ///
    /// - Parameter userId: 用户ID
    func CourseUpdate(CourseId: Int,CourseStatus:CourseStatus){
        let requestPath = "\(RequestHome)\(RequestCourseUpdate)"
        let parameters: Parameters = ["userId": AccountManager.share().userId,
                                      "CourseId":  CourseId,
                                      "CourseStatus": CourseStatus]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseCourseModel>) in
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    self.success(data.result ?? "更新成功")
                case .failure(let error):
                    self.faile(error.localizedDescription)
                }
        }
    }
    
    // 删除课程
    // - Parameter model:
    func CourseDelete(CourseId: Int) {
        let requestPath = "\(RequestHome)\(RequestCourseDelete)"
        let parameters: Parameters = ["userId": AccountManager.share().userId,
                                      "CourseId":  CourseId]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseCourseModel>) in
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    self.success(data.result ?? "更新成功")
                case .failure(let error):
                    self.faile(error.localizedDescription)
            }
        }
    }
    
}




