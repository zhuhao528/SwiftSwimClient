//
//  ResponseCourseModel.swift
//  swim
//
//  Created by qing class on 2017/7/10.
//  Copyright © 2017年 qing class. All rights reserved.
//

import Foundation

import ObjectMapper

class ResponseCourseModel: Mappable {
    var result: String?
    var list: [CourseModel]?
    var errorMessage :String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        list <- map["list"]
        errorMessage <- map["errorMessage"]
    }
}
