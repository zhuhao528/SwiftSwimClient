//
//  Reqeust.swift
//  iOSClientForPerfect
//
//  Created by ZeluLi on 2016/12/3.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

//返回数据解析中使用的字符串常量
let RequestResultSuccess: String = "SUCCESS"
let RequestResultFaile: String = "FAILE"
let ResultListKey = "list"
let ResultKey = "result"
let ErrorMessageKey = "errorMessage"

//网络请求中的闭包回调
typealias RequestStart = () -> Void         //开始请求
typealias RequestSuccess = (Any) -> Void    //请求成功
typealias RequestFailed = (String) -> Void  //请求失败

//请求方式枚举
enum RequestMethodTypes {
    case GET, POST, PUT, DELETE, CUSTOM(String)
    
    /// Convert to String
    public var description: String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        case .PUT: return "PUT"
        case .DELETE: return "DELETE"
        case .CUSTOM(let s): return s
        }
    }
}

//网络请求基类
class BaseRequest {
    var start: RequestStart
    var success: RequestSuccess
    var faile: RequestFailed
    
    init(start: @escaping RequestStart,
         success: @escaping RequestSuccess,
         faile: @escaping RequestFailed) {
        self.start = start
        self.success = success
        self.faile = faile
    }
}
