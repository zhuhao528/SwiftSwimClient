//
//  ResponseUserModel.swift
//  swim
//
//  Created by qing class on 2017/7/18.
//  Copyright © 2017年 qing class. All rights reserved.
//

import Foundation

import ObjectMapper

class ResponseUserModel: Mappable {
    var result: String?
    var list: [UserModel]?
    var errorMessage :String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        list <- map["list"]
        errorMessage <- map["errorMessage"]
    }
}
