//
//  UserInfoRequest.swift
//  iOSClientForPerfect
//
//  Created by ZeluLi on 2016/12/3.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

/// 用户相关的接口请求
class UserInfoRequest:BaseRequest {
    
    /// 通过用户名查询用户信息
    ///
    /// - Parameter userName: 用户名
    func queryUserInfo(account: String){
        let requestPath = "\(RequestHome)\(RequestUserInfoPath)"
        let parameters: Parameters = ["account": account]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
        .responseJSON { (response) in
            print("json")
            print(response.result.value ?? "no json")
        }
        .responseObject{ (response: DataResponse<ResponseModel>) in
            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    return
                }
                guard data.list != nil else{
                    self.faile(data.errorMessage!)
                    return
                }
                let userModel:UserModel = data.list!
                self.success(userModel)
            case .failure(let error):
                self.faile(error.localizedDescription)
            }
        }
    }
    
    /// 注册网络请求
    ///
    /// - Parameters:
    ///   - userName: 用户名
    ///   - password: 密码
    func register(model: UserModel){
        let requestPath = "\(RequestHome)\(RequestUserRegister)"
        let parameters: Parameters = ["userName": model.userName!,
                                      "account": model.account!,
                                      "password": model.password!,
                                      "authority": model.authority]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters).responseObject { (response: DataResponse<ResponseModel>) in
            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    return
                }
                guard data.list != nil  else{
                    self.faile(data.errorMessage!)
                    return
                }
                
                let userModel:UserModel = data.list!
                
                //将用户信息存入单例
                AccountManager.share().userId = userModel.userId!
                AccountManager.share().userName = userModel.userName!
                AccountManager.share().account = userModel.account!
                AccountManager.share().authority = Authority(rawValue: userModel.authority!.rawValue)!
                AccountManager.share().regestTime = String(describing: userModel.regestTime)
                //将用户信息单例归档存入UserDefault中，便于二次登录使用
                self.recoderUserInfo()
                self.success(userModel)
            case .failure(let error):
                self.faile(error.localizedDescription)
                
            }
        }
    }
    
    /// 登录或者注册调用的公共部分，统一处理登录或者注册成功的事件
    ///
    /// - Parameters:
    ///   - requestPath: 请求路径
    ///   - userName: 用户名
    ///   - password: 密码
    func login(account: String, password: String) {
        let requestPath = "\(RequestHome)\(RequestUserLogin)"
        let parameters: Parameters  = ["account": account, "password": password]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters).responseObject { (response: DataResponse<ResponseModel>) in
            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    return
                }
                guard data.list != nil  else{
                    self.faile(data.errorMessage!)
                    return
                }
                
                let userModel:UserModel = data.list!

                //将用户信息存入单例
                AccountManager.share().userId = userModel.userId!
                AccountManager.share().userName = userModel.userName!
                AccountManager.share().account = userModel.account!
                AccountManager.share().authority = Authority(rawValue: userModel.authority!.rawValue)!
                AccountManager.share().regestTime = String(describing: userModel.regestTime)
                //将用户信息单例归档存入UserDefault中，便于二次登录使用
                self.recoderUserInfo()
                self.success(userModel)
            case .failure(let error):
                self.faile(error.localizedDescription)
                
            }
        }
    }
    
    // 修改密码
    /// 通过用户名查询用户信息
    ///
    /// - Parameter userName: 用户名
    func changePassword(model: UserModel){
        let requestPath = "\(RequestHome)\(RequestUserChanagePassword)"
        let parameters: Parameters = ["userId":model.userId!,
                                      "userName": model.userName!,
                                      "account": model.account!,
                                      "password": model.password!,
                                      "authority": model.authority]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseModel>) in
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    let userModel:UserModel = data.list!
                    self.success(userModel)
                case .failure(let error):
                    self.faile(error.localizedDescription)
                }
        }
    }
    
    // 删除用户
    ///
    /// - Parameter userName: 用户名
    func accountDelete(userId: String){
        let requestPath = "\(RequestHome)\(RequestUserDelete)"
        let parameters: Parameters = ["userId": userId]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseModel>) in
                switch response.result {
                case .success:
                    guard let data = response.result.value else {
                        return
                    }
                    guard data.list != nil else{
                        self.faile(data.errorMessage!)
                        return
                    }
                    let userModel:UserModel = data.list!
                    self.success(userModel)
                case .failure(let error):
                    self.faile(error.localizedDescription)
            }
        }
    }
    
    /// 通过用户ID获取当前用户的Note列表
    ///
    /// - Parameter userId: 用户ID
    func fetchUserList(page: Int,pageSize:Int){
        let requestPath = "\(RequestHome)\(RequestUserList)"
        let parameters: Parameters = ["userId": AccountManager.share().userId,
                                      "page":page,
                                      "pageSize":pageSize]
        Alamofire.request("\(requestPath)",method: .post,parameters: parameters)
            .responseJSON { (response) in
                print("json")
                print(response.result.value ?? "no json")
            }
            .responseObject{ (response: DataResponse<ResponseUserModel>) in
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
                    let userList:[UserModel] = data.list!
                    self.success(userList)
                case .failure(let error):
                    self.faile(error.localizedDescription)
                }
        }
    }
    
    /// 将用户信息单例归档存入UserDefault中，便于二次登录使用
    func recoderUserInfo() {
        let data = NSKeyedArchiver.archivedData(withRootObject: AccountManager.share())
        UserDefaults.standard.setValue(data, forKey: LoginUserInfoKey)
    }
    
    
    /// 退出登录，清空归档信息
    static func loginOut() {
        UserDefaults.standard.removeObject(forKey: LoginUserInfoKey)
    }
}
