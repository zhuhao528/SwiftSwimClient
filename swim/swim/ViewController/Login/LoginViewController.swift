
//
//  Login.swift
//  swim
//
//  Created by qing class on 2017/6/13.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    var userInfo: UserModel!
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var loginOrRegisterButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.passwordTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Event Response
    
    /// 点击登录或者注册按钮
    ///
    /// - Parameter sender:
    @IBAction func tapLoginOrRegisterButton(_ sender: UIButton) {
        if passwordTextField.text! == "" {
            Tools.showTap(message: "请输入密码", superVC: self)
            return
        }
//        if !Tools.checkPassword(password: passwordTextField.text! as NSString) {
//            Tools.showTap(message: "请输入有效密码", superVC: self)
//            return
//        }

        self.login()
    }
    
    /// 回收键盘
    ///
    /// - Parameter sender:
    @IBAction func tapGestrueRecognizer(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //MARK: - Private Method
    
    /// 配置当前VC
    private func configVC() {
        if userInfo != nil {
            self.userNameLabel.text = userInfo.userName
            self.title = "登录"
            self.passwordTextField.placeholder = "请输入登录密码"
        }
    }
    
    /// 登录
    func login() {
        requestObj().login(account: userInfo.account!, password: passwordTextField.text!)
    }
    
    /// 创建UserInfoRequest对象
    ///
    /// - Returns:
    func requestObj() -> UserInfoRequest {
        return UserInfoRequest(start: {
        }, success: { (userModel) in
            DispatchQueue.main.async {
                self.goMainPage()
            }
            
        }) { (errorMessage) in
            DispatchQueue.main.async {
                Tools.showTap(message: errorMessage, superVC: self)
            }
        }
    }
    
    /// 进入首页
    func goMainPage() {
        switch AccountManager.share().authority {
        case .Ordinary:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainTabBar")
            self.present(vc, animated: true) {
                UIApplication.shared.delegate?.window??.rootViewController = vc
            }
            break
        case .Manage:
            let vc = UIStoryboard.init(name: "Manage", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageTabBar")
            self.present(vc, animated: true) {
                UIApplication.shared.delegate?.window??.rootViewController = vc
            }
        }
    }
    
}
