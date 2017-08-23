//
//  Tools.swift
//  iOSClientForPerfect
//
//  Created by ZeluLi on 2016/12/3.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import UIKit
class Tools: NSObject {
    static func showTap(message: String, superVC: UIViewController) {
        let alter = UIAlertView(title: "提示", message: message, delegate: nil, cancelButtonTitle: "OK")
        alter.show()
    }
    
    // 匹配手机号 正则匹配手机号
    static func checkTelNumber(phoneNum:String)-> Bool {
        let phoneRegex = "^1+[3578]+\\d{9}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@" , phoneRegex)
        return (phoneTest.evaluate(with: phoneNum));
    }
    
    // 匹配用户名 正则匹配用户姓名,20位的中文或英文
    static func checkUserName(userName:NSString)-> Bool
    {
        let pattern = "^[a-zA-Z\u{4E00}-\u{9FA5}]{1,20}";
        let pred = NSPredicate(format: "SELF MATCHES %@" , pattern)
        return (pred.evaluate(with: userName));
    }

    // 匹配密码 正则匹配用户密码6-18位数字和字母组合
    static func checkPassword(password:NSString)-> Bool
    {
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
        let pred = NSPredicate(format: "SELF MATCHES %@" , pattern)
        return (pred.evaluate(with: password));
    }
}
