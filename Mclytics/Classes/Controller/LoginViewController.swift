//
//  LoginViewController.swift
//  Mclytics
//
//  Created by Gunjan Raval on 11/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: ParentClass,UITextFieldDelegate {
    
    private var stackView:UIView!
    
    private var emailTextField:InputTextField!
    private var passwordTextField:InputTextField!
    
    private var signInButton:CustomButton!
    private var rememberMeButton:UIButton!
    private var forgotPasswordButton:UIButton!
    private var signUpButton:UIButton!
    private var showHidePasswordButton:UIButton!
    
    private var imgCheckbox:UIImageView!
    private var isRememberMe = true
    private var isShowPassword = false
    
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!

    var viewcontroller : ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadHeaderView()
        // Do any additional setup after loading the view.
    }
    func loadHeaderView() {
        
        headerview = UIView(frame: CGRect(x: 0, y:( STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)), width: Int(UIScreen.main.bounds.width), height: 44));
        headerview.backgroundColor = colorPrimary
        self.view.addSubview(headerview)
        
        self.buttonBack = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        self.buttonBack.setTitle("Login", for: .normal)
        self.buttonBack.setTitleColor(.white, for: .normal)
        self.buttonBack.contentHorizontalAlignment = .center
        self.buttonBack.backgroundColor = UIColor.clear
        headerview.addSubview(self.buttonBack)
        self.initDesign()
    }
    
    private func initDesign() {
        
        
        stackView = UIView(frame: CGRect(x: X_PADDING, y: Int(headerview.frame.maxY), width: SCREEN_WIDTH - (X_PADDING*2), height: 300))
        stackView.backgroundColor = .clear

        let imgLogo = UIImageView(frame: CGRect(x: 0, y: 30, width: 229, height: 120))
        imgLogo.backgroundColor = .clear
        imgLogo.image = UIImage(named: "logo")
        imgLogo.contentMode = .scaleAspectFit
        imgLogo.center = CGPoint(x: self.view.center.x - 15, y:  imgLogo.frame.origin.y/2)
        stackView.addSubview(imgLogo)
        
        var yPosition = Int(imgLogo.frame.maxY + ParentClass.sharedInstance.iPhone_X_Top_Padding + 50)
        self.view.backgroundColor = UIColor.white
        
        emailTextField = InputTextField(frame: CGRect(x: 0, y: yPosition, width: Int(stackView.frame.size.width), height: CUSTOM_TEXTFIELD_HEIGHT))
        print(emailTextField.frame)
        emailTextField.placeholder = "Email"
        emailTextField.text = "admin@mclytics.com"
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
        emailTextField.keyboardType = .emailAddress
        stackView .addSubview(emailTextField)
        self.view.addSubview(stackView)

        yPosition += CUSTOM_TEXTFIELD_HEIGHT + 20
        
        self.passwordTextField = InputTextField(frame: CGRect(x: 0, y: yPosition, width: Int(stackView.frame.size.width), height: CUSTOM_TEXTFIELD_HEIGHT))
        self.passwordTextField.placeholder = "Password"
        self.passwordTextField.text = "mclytics@2019"
        self.passwordTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.returnKeyType = .done
        stackView.addSubview(self.passwordTextField)

        self.showHidePasswordButton = UIButton(frame: CGRect(x: Int(stackView.frame.size.width) - 40, y: yPosition - 5, width: 40, height: 40))
        self.showHidePasswordButton.backgroundColor = UIColor.clear
        self.showHidePasswordButton.contentHorizontalAlignment = .center
        self.showHidePasswordButton.setImage(UIImage(named: "hidePasswordIcon"), for: .normal)
        self.showHidePasswordButton.addTarget(self, action: #selector(showHidePassword(sender:)), for: .touchUpInside)
        stackView.addSubview(self.showHidePasswordButton)

        yPosition += CUSTOM_TEXTFIELD_HEIGHT + 20

        imgCheckbox = UIImageView(frame: CGRect(x: 0, y: yPosition + 4, width: 24, height: 24))
        imgCheckbox.image = UIImage(named: "selectedCheckboxBlue")
        stackView.addSubview(imgCheckbox)

        self.rememberMeButton = UIButton(frame: CGRect(x: 0 , y: yPosition, width: 140, height: CUSTOM_TEXTFIELD_HEIGHT))
        self.rememberMeButton.backgroundColor = UIColor.clear
        self.rememberMeButton.setTitleColor(labelTextColor, for: .normal)
        self.rememberMeButton.contentHorizontalAlignment = .right
        self.rememberMeButton.titleLabel?.font = UIFont(name: APP_FONT_NAME, size: SMALL_BUTTON_FONT_SIZE)
        self.rememberMeButton.setTitle("Remember Me", for: .normal)
        self.rememberMeButton.addTarget(self, action: #selector(rememberMePressed(sender:)), for: .touchUpInside)
        stackView.addSubview(self.rememberMeButton)

        yPosition += CUSTOM_TEXTFIELD_HEIGHT + 20

        signInButton = CustomButton(frame: CGRect(x: Int(stackView.frame.size.width/2), y: yPosition, width: Int(stackView.frame.size.width/2), height: CUSTOM_BUTTON_HEIGHT))
        self.signInButton.setTitle("Submit", for: .normal)
        signInButton.addTarget(self, action: #selector(signInPressed(sender:)), for: .touchUpInside)
        stackView.addSubview(signInButton)

        yPosition += (CUSTOM_BUTTON_HEIGHT + 20)
        stackView.frame.size.height = CGFloat(yPosition + CUSTOM_TEXTFIELD_HEIGHT)
        stackView.center = self.view.center
    }
    
    //MARK: action
    @objc func signInPressed(sender:UIButton) {
        if (self.isShowPassword == true) {
        ParentClass.sharedInstance.setData(strData: true, strKey: REMEMBER_ME_KEY)
        }
        if (self.emailTextField.text == "") {
            super.showAlert(message: "Please Enter Email", type: .error, navBar: false)
            return
        } else if (self.passwordTextField.text == "") {
             super.showAlert(message: "Please Enter Password", type: .error, navBar: false)
            return
        }
        WebServicesManager.login(email: self.emailTextField.text!, password: self.passwordTextField.text!, onCompletion: { (responce) in
            var strToken: String = ""
            var strMsg: String = ""

            strToken = responce!["token"].stringValue
            strMsg = responce!["message"].stringValue

            if strMsg != ""{
                super.showAlert(message: strMsg, type: .error, navBar: false)
                return
            }
            self.saveUserData(strtoken: strToken)
            
        }) { (error) in
            print(error as Any)
            super.showAlert(message: CS.Common.wrongMsg, type: .error, navBar: false)

        }
        
    }
    @objc func forgotPasswordPressed(sender:UIButton) {
        
    }
    
    @objc func rememberMePressed(sender:UIButton) {
        
        if (self.isRememberMe == true) {
            self.imgCheckbox.image = UIImage(named: "deselectedCheckbox")
            self.isRememberMe = false
            ParentClass.sharedInstance.setData(strData: false, strKey: REMEMBER_ME_KEY)
        } else {
            self.imgCheckbox.image = UIImage(named: "selectedCheckboxBlue")
            self.isRememberMe = true
        }
    }
    
    @objc func showHidePassword(sender:UIButton) {
        
        if (self.isShowPassword == true) {
            self.showHidePasswordButton.setImage(UIImage(named: "hidePasswordIcon"), for: .normal)
            self.passwordTextField.isSecureTextEntry = true
            self.isShowPassword = false
        } else {
            self.showHidePasswordButton.setImage(UIImage(named: "showPasswordIcon"), for: .normal)
            self.passwordTextField.isSecureTextEntry = false
            self.isShowPassword = true
        }
        
    }
    
    @objc func btnBackPressed(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    private func saveUserData(strtoken:String) {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        ParentClass.sharedInstance.setData(strData: strtoken , strKey: TOKEN_KEY)
        ParentClass.sharedInstance.setData(strData: self.isRememberMe, strKey: REMEMBER_ME_KEY)
        ParentClass.sharedInstance.setData(strData: self.emailTextField.text!, strKey: USERNAME_KEY)
        ParentClass.sharedInstance.setData(strData: self.passwordTextField.text!, strKey: PASSWORD_KEY)
        ParentClass.sharedInstance.token =  strtoken
        goToNextScreen()
    }
    
    private func goToNextScreen() {
        
        self.viewcontroller = ViewController()
        self.navigationController?.pushViewController(self.viewcontroller!, animated: true)
//        self.present(self.viewcontroller!, animated: true, completion: nil)
        
        
        //        self.myNavigationController = NavigationController(rootViewController: self.vcKhadiStore!)
        //        self.myNavigationController?.navigationBar.isHidden = true
        //        self.myNavigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //
        //        let mainViewController = MainViewController()
        //        mainViewController.isLeftViewStatusBarHidden = false
        //        mainViewController.rootViewController = myNavigationController
        //        mainViewController.myVTVNavigarionController = myNavigationController
        //        mainViewController.setup(type: UInt(1))
        //        // mainViewController.setup(type: UInt(9))
        //        mainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
        //
        //        let window = UIApplication.shared.delegate!.window!!
        //        window.rootViewController = mainViewController
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
