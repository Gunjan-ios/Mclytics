//
//  ParentViewController.swift
//  GEM
//
//  Created by Gunjan Raval on 8/23/18.
//  Copyright © 2018 Gunjan Raval. All rights reserved.
//

import UIKit
import LIHAlert
import SwiftyJSON
//import KOLocalizedString

class ParentClass: UIViewController{
   
    static let sharedInstance = ParentClass()

    // ----------------------------------------------------------
    // MARK: Private Members
    // ----------------------------------------------------------
    var alert: LIHAlert?
    var processingAlert: LIHAlert?
    var alertNoNavBar: LIHAlert?
    var APP = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    var iPhone_SE:Bool = false
    var iPhone_X_Top_Padding:CGFloat = 0
    var iPhone_X_Bottom_Padding:CGFloat = 0
    var token : String!
    var CONNECTED_WITH : String!
//    var CONNECTED_NET : String!
//    var saveListArray : [[String : Any]] = [[String:Any]]()
    var saveListArray1 : [JSON] = [JSON]()
//    var tempArray : [JSON] = [JSON]()
    var editListArray1 : [JSON] = [JSON]()

    
    var saveListArray = [MainFormModal]()
    var editListArray = [MainFormModal]()
    var finalizedListArray = [MainFormModal]()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initAlerts()
        self.view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        let imgNav = UIView (frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: STATUS_BAR_HEIGHT))
        imgNav.backgroundColor = colorPrimary
        self.view.addSubview(imgNav)
        
//        if ParentClass.sharedInstance.getDataForKey(strKey: AUTO_WIFI) as? Bool == true{
//            CONNECTED_WITH = "CONNECTED_WIFI"
//        }
//        if ParentClass.sharedInstance.getDataForKey(strKey: AUTO_NETWORK)  as? Bool == true{
//            CONNECTED_WITH = "CONNECTED_NET"
//        }
       if APP.open_count == 1{
        APP.open_count = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        }
    }
    func setData(strData:Any,strKey:String) {
        
        UserDefaults.standard.set(strData, forKey: strKey)
        UserDefaults.standard.synchronize()
    }
    
    func getDataForKey(strKey:String) -> Any {
        return UserDefaults.standard.value(forKey: strKey) as Any
    }
    
    func dateConvert(date: Double?) -> String{
        
        if let timeResult = date {
            let date = NSDate(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .medium //Set time style
            dateFormatter.dateStyle = .medium //Set date style
            let localDate = dateFormatter.string(from: date as Date)
            return localDate
        }else{
            return ""
        }
    }
    func getDataJSON(key:String) -> [MainFormModal] {
        if let listArray = self.getDataForKey(strKey: key) as? Data {
            if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: listArray) as? [MainFormModal] {
                return decodedArray
            }
        }
        return [MainFormModal]()
    }
    
    func setJSON(json: [MainFormModal], key:String)  {
      let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject:json)
       self.setData(strData: encodedData, strKey: key)
    }
//    public func loadJSON(strKey:String) -> JSON {
//        let defaults = UserDefaults.standard
//        return JSON (parseJSON: (defaults.value(forKey: strKey) as! String))
////        return JSON.parse(defaults.valueForKey(strKey) as! String))
//        // JSON from string must be initialized using .parse()
//    }

    func getColorFromString(pString:String) -> UIColor {
        
        var strokeColorInString = pString
        strokeColorInString = strokeColorInString.replacingOccurrences(of: "rgba(", with: "")
        strokeColorInString = strokeColorInString.replacingOccurrences(of: ")", with: "")
        
        let strokesArray = strokeColorInString.components(separatedBy: ",")
        
        return UIColor(red:  CGFloat(Double(strokesArray[0])!/255.0), green: CGFloat(Double(strokesArray[1])!/255.0), blue: CGFloat(Double(strokesArray[2])!/255.0), alpha:  CGFloat(Double(strokesArray[3])!))
    }
    @objc func networkStatusChanged(_ notification: Notification) {

        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            APP.open_count = 2
//           self.processingAlert?.show(nil, hidden: nil)
         case .online(.wwan):
            print("Connected via WWAN")
            
            self.setData(strData: CONNECTED_NET  , strKey: CONNECTED)
            self.processingAlert?.hideAlert({ () -> () in
                if self.APP.open_count == 2 {
                    self.APP.open_count = 0
//                    self.showAlert(message: Language.Common.Connected, type: AlertType.success, navBar: false)
                }
                    })
        case .online(.wiFi):
            print("Connected via WiFi")
          CONNECTED_WITH = "CONNECTED_WIFI"
            self.setData(strData: CONNECTED_WIFI, strKey: CONNECTED)

            self.processingAlert?.hideAlert({ () -> () in
                if self.APP.open_count == 2 {
                    self.APP.open_count = 0
//                    self.showAlert(message: Language.Common.Connected, type: AlertType.success, navBar: false)
                }
                    })
        }
    }
    
    func initAlerts() {
        self.alert = AlertManager.getErrorAlert()
        self.alertNoNavBar = AlertManager.getErrorAlertNoNavBar()
        self.processingAlert = AlertManager.FetchErrorAlert()
        self.alert?.initAlert(self.view)
        self.alertNoNavBar?.initAlert(self.view)
        self.processingAlert?.initAlert(self.view)
    }

    
    func showAlert(message: String, type: AlertType, navBar: Bool) {

        let alt = navBar ? alert : alertNoNavBar

        if type == AlertType.success {
            alt?.alertColor = AlertManager.successColor
        } else if type == AlertType.error {
            alt?.alertColor = AlertManager.errorColor
        }
        alt?.contentText = message
        alt?.show(nil, hidden: nil)
    }
    
    func showAlert(title: String?, message: String?, yesAction: UIAlertAction, noAction: UIAlertAction) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        self.showDetailViewController(alert, sender: self)
    }
    
//    func heightForView(text:String?, width:CGFloat , Label : CustomLabel) -> Int{
//        let hValue = CGFloat.greatestFiniteMagnitude
//        Label.frame.size.height = hValue
//        Label.numberOfLines = 0
//        Label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        Label.text = text
//        Label.sizeToFit()
//        //if Int(Label.frame.height) < LABEL_HEIGHT || Int(Label.frame.height)  <= 41 {
//        
//        if Int(Label.frame.height) < LABEL_HEIGHT  {
//            return LABEL_HEIGHT
//        }
//        else{
//            return Int(Label.frame.height)
//        }
//    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Actions -
    //––––––––––––––––––––––––––––––––––––––––
    /// Function for change localization
   
//    func OnLanguagePressed() {
//        let alertController = UIAlertController(title: KOLocalizedString(Language.Common.ChooseLanguage), message: nil, preferredStyle: .actionSheet)
//        
//        let EnglishAction = UIAlertAction(title: KOLocalizedString(Language.Common.English), style: .default) { action in
//            KOSetLanguage("en")
//        }
//        alertController.addAction(EnglishAction)
//        
//        let HindiAction = UIAlertAction(title: KOLocalizedString(Language.Common.Hindi), style: .default) { action in
//            KOSetLanguage("hi")
//        }
//        
//        alertController.addAction(HindiAction)
//        
//        let cancelAction = UIAlertAction(title: KOLocalizedString(Language.Common.Cancel), style: .cancel) { action in }
//        alertController.addAction(cancelAction)
//        
//        self.present(alertController, animated: true)
//    }

    
    
}
