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
import KOLocalizedString

class AlertManager: LIHAlertManager {

    static let errorColor = ERROR_COLOR
    static let successColor = SUCCESS_COLOR

    static func getErrorAlert() -> LIHAlert
    {
        let alert = super.getTextAlert(message: KOLocalizedString(Language.Common.defaultFailedMessage))
        alert.alertColor = errorColor
        alert.alertAlpha = 1.0
        alert.autoCloseTimeInterval = 2.0
        
        if UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 896
        {
                    alert.alertHeight += 20
                    alert.paddingTop += 10

        }
//      if UIScreen.main.bounds.size.height == 896
//        {
//            alert.alertHeight += 20
//            alert.paddingTop += 10
//
//        }

        return alert
    }

    static func getErrorAlertNoNavBar() -> LIHAlert {

        let alert = super.getTextAlert(message: KOLocalizedString(Language.Common.defaultFailedMessage))
        alert.alertColor = errorColor
        alert.alertAlpha = 1.0
        alert.autoCloseTimeInterval = 2.0
        alert.hasNavigationBar = false
        alert.alertHeight += 20
        alert.paddingTop += 10
        return alert
    }
    
    static func FetchErrorAlert() -> LIHAlert
    {
        let  alert = super.getProcessingAlert(message: KOLocalizedString(Language.Common.Internet))
        alert.alertColor = errorColor
        alert.alertAlpha = 1.0
        alert.autoCloseTimeInterval = 2.0
        alert.touchBackgroundToDismiss = true
        alert.dimsBackground = true
        if UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 896
        {
            alert.alertHeight += 20
            alert.paddingTop += 10
            
        }
//        if UIScreen.main.bounds.size.height == 896
//        {
//            alert.alertHeight += 25
//            alert.paddingTop += 12.5
//
//        }
        return alert
    }
    
    
}

