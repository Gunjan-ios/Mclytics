//
//  AlertManager.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation
import LIHAlert

class AlertManager: LIHAlertManager {

    static let errorColor = ERROR_COLOR
    static let successColor = SUCCESS_COLOR


    static func getErrorAlert() -> LIHAlert
    {
        let alert = super.getTextAlert(message: Language.Common.defaultFailedMessage)
        alert.alertColor = errorColor
        alert.alertAlpha = 1.0
        alert.autoCloseTimeInterval = 2.0
        
//        if IS_IPHONE_X_XR_XMAX{
//                    alert.alertHeight += 15
//                    alert.paddingTop += 10
//        }

        return alert
    }

    static func getErrorAlertNoNavBar() -> LIHAlert {

        let alert = super.getTextAlert(message: Language.Common.defaultFailedMessage)
        alert.alertColor = errorColor
        alert.alertAlpha = 1.0
        alert.autoCloseTimeInterval = 2.0
        alert.hasNavigationBar = false
        
        if IS_IPHONE_X_XR_XMAX{
            alert.alertHeight += 35
            alert.paddingTop += 20
        }else{
            alert.alertHeight += 15
            alert.paddingTop += 10
        }
       
        return alert
    }
    
    static func FetchErrorAlert() -> LIHAlert
    {
        let  alert = super.getProcessingAlert(message: Language.Common.Internet)
        alert.alertColor = errorColor
        alert.alertAlpha = 1.0
        alert.autoCloseTimeInterval = 2.0
        alert.touchBackgroundToDismiss = true
        alert.dimsBackground = true
        alert.hasNavigationBar = false
        if IS_IPHONE_X_XR_XMAX{
            alert.alertHeight += 35
            alert.paddingTop += 20
        }else{
            alert.alertHeight += 15
            alert.paddingTop += 10
        }
        return alert
    }
    
    
}

