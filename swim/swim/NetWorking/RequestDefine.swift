//
//  RequestPathDefine.swift
//  iOSClientForPerfect
//
//  Created by ZeluLi on 2016/12/3.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let LoginUserInfoKey = "LoginUserInfoKey"       //归档用户信息使用的key
let loginTokenKey = "key" //尚未实现，此Demo的二次登录先记录Password来实现

//与请求相关的定义
//let RequestHome = "http://10.10.146.198:8181"               //host
//let RequestHome = "http://127.0.0.1:8888"               //host
let RequestHome = "http://122.152.204.172:8888"               //host
let RequestUserInfoPath = "/queryUserInfoByAccount"    //通过用户名查询用户信息
let RequestUserLogin = "/login"                         //登录
let RequestUserRegister = "/register"                   //注册
let RequestUserChanagePassword = "/chanagePassword"    //修改密码
let RequestUserDelete = "/delete"                       //删除账号
let RequestUserList = "/userList"                      //获取用户列表
let RequestCourseList = "/CourseList"                 //获取课程列表 不展示被驳回的列表
let RequestUserCourseList = "/UserCourseList"          //获取课程列表
let RequestExportForms = "/ExportForms"            //导出报表
let RequestCourseAdd = "/CourseAdd"                   //添加笔记
let RequestCourseUpdate = "/CourseUpdate"             //更新笔记
let RequestCourseDelete = "/CourseDelete"             //删除笔记


