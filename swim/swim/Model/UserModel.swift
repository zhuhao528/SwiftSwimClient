//
//  UserModel.swift
//  iOSClientForPerfect
//
//  Created by ZeluLi on 2016/12/3.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation
import ObjectMapper

enum Authority:String {
    case Manage = "Manage"
    case Ordinary = "Ordinary"
}

class UserModel : Mappable{
    public var userId: String?
    public var userName: String?
    public var account: String?
    public var password: String?
    public var authority : Authority!
    public var regestTime: Date?
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }

    func mapping(map: Map) {
        userId     <- map["userId"]
        userName   <- map["userName"]
        account   <- map["account"]
        password   <- map["password"]
        authority     <- (map["authority"],EnumTransform<Authority>())
        regestTime <- (map["regestTime"], DateTransform())
    }
}
