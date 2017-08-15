//
//  CourseModel.swift
//  swim
//
//  Created by qing class on 2017/7/7.
//  Copyright © 2017年 qing class. All rights reserved.
//

import Foundation
import ObjectMapper

enum CourseType:String{
    case Theory = "Theory"
    case SwimmingPool = "SwimmingPool"
}

enum CourseStatus:String {
    case Order = "Order"
    case Reject = "Reject"
    case Pass = "Pass"
}

class CourseModel: Mappable{
    
    var CourseId: Int?
    var UserId: Int?
    var CourseType : CourseType!
    var TeacherName: String?
    var SchoolDate: Date?
    var SchoolTime: String?
    var StudentsNumber: Int?
    var StudentsNames: String?
    var CourseStatus : CourseStatus!
    
    required init?(map: Map) {
        
    }
    
    init() {

    }

    func mapping(map: Map) {
        CourseId <- map["CourseId"]
        UserId <- map["UserId"]
        CourseType     <- (map["CourseType"],EnumTransform<CourseType>())
        TeacherName    <- map["TeacherName"]
        SchoolDate     <- (map["SchoolDate"], DateTransform())
        SchoolTime     <- map["SchoolTime"]
        StudentsNumber <- map["StudentsNumber"]
        StudentsNames  <- map["StudentsNames"]
        CourseStatus   <- (map["CourseStatus"],EnumTransform<CourseStatus>())
    }
    
    init(CourseType:CourseType,CourseStatus:CourseStatus,TeacherName: String,SchoolDate: Date,SchoolTime: String,StudentsNumber: Int,StudentsNames: String) {
        self.CourseStatus = CourseStatus
        self.CourseType = CourseType
        self.TeacherName = TeacherName
        self.StudentsNumber = StudentsNumber
        self.SchoolTime = SchoolTime
        self.StudentsNames = StudentsNames
        self.SchoolDate = SchoolDate
    }
}
