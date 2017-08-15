//
//  me.swift
//  swim
//
//  Created by qing class on 2017/7/4.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var authorityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text =  AccountManager.share().userName
        accountLabel.text = AccountManager.share().account
        switch AccountManager.share().authority {
        case .Manage:
            authorityLabel.text = "管理"
        default:
            authorityLabel.text = "普通"
        }
    }
    
    // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Response Event
    @IBAction func tapLoginOutButton(_ sender: Any) {
        UserInfoRequest.loginOut()
        UIApplication.shared.delegate?.window??.rootViewController = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVCNC")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
