//
//  Hud.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation
import SVProgressHUD

class Hud {
    
    static var isShowing = false
    
    static func config() {
        SVProgressHUD.setHapticsEnabled(true)
        SVProgressHUD.setMaxSupportedWindowLevel(UIWindow.Level.statusBar)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }
    
    static func show() {
        
        if !self.isShowing {
            self.isShowing = true
            UIApplication.shared.beginIgnoringInteractionEvents()
            SVProgressHUD.setBackgroundColor(UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9))
            SVProgressHUD.setForegroundColor(UIColor.white)
            SVProgressHUD.show()
        }
    }
    
    static func show(message: String) {
        
        if !self.isShowing {
            self.isShowing = true
            UIApplication.shared.beginIgnoringInteractionEvents()
            SVProgressHUD.setBackgroundColor(UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9))
            SVProgressHUD.setForegroundColor(UIColor.white)
            SVProgressHUD.setFont(UIFont .boldSystemFont(ofSize: 14))
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    static func dismiss() {
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
        self.isShowing = false
    }
    
    static func showSuccess(message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
        UIApplication.shared.endIgnoringInteractionEvents()
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        self.isShowing = false

    }
    
    static func showError(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
    
    static func changeMessage(message: String) {
        SVProgressHUD.setStatus(message)
    }
}

