//
//  GISWebServicesManager.swift
//  TestSpatialite
//
//  Created by Gaurav on 20/09/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let BASE_URL = "http://mclytics.com/api/"
//let BASE_URL = "http://192.168.20.62:8090/"
let LOGIN_URL = "login"
let FORMS_URL = "forms"
let SUBMIT_URL = "forms/formid/submit"
let ADDINSPECTION_URL = "api/kvic/addInspectionData"
let UPLOAD_URL = "api/kvic/upload"
let DELETE_ATTACHMENT_URL = "api/kvic/deleteAttachment"

let LOGINBYPASS_URL = "api/kvic/login"
let REVERSE_GEOCODING_URL = "api/kvic/reverseGeocoding"
let FINAL_SUBMIT_URL = "api/kvic/finalSubmit"
let LOGIN_DATA_BY_USER = "api/kvic/loginDataByUser"
//let UPLOAD_URL = "api/kvic/upload"


class WebServicesManager {
    
    class func login(email:String, password:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [
            CS.Params.email: email,
            CS.Params.password: password
        ]
        
        Alamofire.request("\(BASE_URL)\(LOGIN_URL)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            let json = JSON(value)
            print(json)

            if let err = response.error{
                onError?(err)
                return
            }

            onCompletion!(json)
     
        }
        
    }
    
//    class func getInspectionView(userName:String, password:String,appType:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//
//        Hud.showLoading(title: Strings.Common.waiting)
//        let parameters: Parameters = [
//            "appType": appType,
//            "userName": userName,
//            "password": password
//        ]
//
//        Alamofire.request("\(BASE_URL)\(LOGIN_URL)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
//            Hud.hideLoading()
//            guard let value = response.result.value
//                else {
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    return }
//            let json = JSON(value)
//            print(json)
//
//            if let err = response.error{
//                onError?(err)
//                return
//            }
//
//
//            onCompletion!(json)
//
//
//        }
//
//    }
//
//    class func getAddressFromLocation(latitude:Double, longitude:Double, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//
//        Hud.showLoading(title: Strings.Common.waiting)
//           let parameters: Parameters = [
//               "lat": "\(latitude)",
//               "lng": "\(longitude)"
//           ]
//
//           Alamofire.request("\(BASE_URL)\(REVERSE_GEOCODING_URL)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
//               Hud.hideLoading()
//               guard let value = response.result.value
//                   else {
//                       if let err = response.error{
//                           onError?(err)
//                           return
//                       }
//                       return }
//               let json = JSON(value)
//               print(json)
//
//               if let err = response.error{
//                   onError?(err)
//                   return
//               }
//
//               onCompletion!(json)
//
//           }
//
//       }
//
//    class func deleteImageWS(appId:String, attachmentName:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//
//        Hud.showLoading(title: Strings.Common.waiting)
//        let parameters: Parameters = [
//            "appId": appId,
//            "attachmentName": attachmentName
//        ]
//
//        Alamofire.request("\(BASE_URL)\(DELETE_ATTACHMENT_URL)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
//            Hud.hideLoading()
//
//            guard let value = response.result.value
//                else {
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                return }
//
//            let json = JSON(value)
//            print(json)
//
//            onCompletion!(json)
//
//        }
//
//    }
//
//    class func signInWS(userName:String, password:String,appType:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//
//        Hud.showLoading(title: Strings.Common.waiting)
//        let parameters: Parameters = [
//            "username": userName,
//            "password": password,
//            "appType": appType,
//        ]
//
//        Alamofire.request("\(BASE_URL)\(LOGIN_URL)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
//            Hud.hideLoading()
//
//            guard let value = response.result.value
//                else {
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                return }
//
//            let json = JSON(value)
//            print(json)
//
//            let userid = json["data"]["user_config"]["user_id"].stringValue
//            print(userid)
//
//            let ord_id = json["data"]["map_config"]["org_id"].stringValue
//            print(ord_id)
//
//            let access_id = json["data"]["user_config"]["default_access_id"].stringValue
//            print(access_id)
//
//            let category_id = json["data"]["user_config"]["cat_config"]["operational"][0]["category_id"].stringValue
//            print(category_id)
//
////            SingletonClassSwift.sharedInstance.setData(strData: userid, strKey: USER_ID)
////            SingletonClassSwift.sharedInstance.setData(strData: ord_id, strKey: ORG_ID)
////            SingletonClassSwift.sharedInstance.setData(strData: access_id, strKey: ACCESS_ID)
////            SingletonClassSwift.sharedInstance.setData(strData: category_id, strKey: CATEGORY_ID)
////
//            onCompletion!(json)
//
//        }
//
//    }
//
//    class func getStoresData(onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//
//
////        let userid = SingletonClassSwift.sharedInstance.getDataForKey(strKey: USER_ID)
////       print(userid)
////
////       let ord_id = SingletonClassSwift.sharedInstance.getDataForKey(strKey: ORG_ID)
////       print(ord_id)
////
////       let access_id = SingletonClassSwift.sharedInstance.getDataForKey(strKey: ACCESS_ID)
////       print(access_id)
////
////       let category_id = SingletonClassSwift.sharedInstance.getDataForKey(strKey: CATEGORY_ID)
////       print(category_id)
//
//        let parameters: Parameters = [
////            "user_id": userid,
////            "org_id": ord_id,
////            "access_id": access_id,
////            "category_id": category_id,
//        ]
//
//        Alamofire.request("\(BASE_URL)\(LOGIN_DATA_BY_USER)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
////            Hud.hideLoading()
//
//            guard let value = response.result.value
//                else {
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    return }
//            let json = JSON(value)
//            print(json)
//
//            if let err = response.error{
//                onError?(err)
//                return
//            }
//           onCompletion!(json)
//        }
//
//    }
//
//    class func getPreviewDataWS(appId:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//        Hud.showLoading(title: Strings.Common.waiting)
//
//        let parameters: Parameters = [
//            "appId": appId
//        ]
//
//        Alamofire.request("\(BASE_URL)\(PREVIEWDATA_URL)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
//            Hud.hideLoading()
//
//            guard let value = response.result.value
//                else {
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    return }
//            let json = JSON(value)
//            print(json)
//
//            if let err = response.error{
//                onError?(err)
//                return
//            }
//           onCompletion!(json)
//        }
//
//    }
//    class func getMarkAsNonTracebleWS(appId:String,verificationStatus:String,agencyName:String,remarks:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//        Hud.showLoading(title: Strings.Common.waiting)
//
//        let parameters: Parameters = [
//            "appId":appId,
//            "verificationStatus" : verificationStatus,
//            "agencyName" : agencyName,
//            "remarks" : remarks
//        ]
//
//
//        Alamofire.request("\(BASE_URL)\(MARKASNONTRACEBLE_URL)", method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
//            Hud.hideLoading()
//
//            guard let value = response.result.value
//                else {
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    return }
//            let json = JSON(value)
//            print(json)
//
//            if let err = response.error{
//                onError?(err)
//                return
//            }
//
//            onCompletion!(json)
//
//        }
//    }
//
//    class func addDetail_forInspectionWS(appId:String, unitProd:NSMutableDictionary!,unitMMInfo:NSMutableDictionary!,unitInfo:NSMutableDictionary!,verifierInfo:String!, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//        Hud.showLoading(title: Strings.Common.waiting)
//
//        let unitProd: Parameters = [
//            "appId":appId,
//            "year" : unitProd["year"] as! String,
//            "salesValue" : unitProd["salesValue"] as! String,
//            "prodValue" : unitProd["prodValue"] as! String
//        ]
//        let unitMMInfo: Parameters = [
//            "appId":appId,
//            "isMmCallback" : unitMMInfo["isMmCallback"] as! Bool,
//             "callBackAmt" : unitMMInfo["callBackAmt"] as! String,
//            "callbackReason" : unitMMInfo["callbackReason"] as! String
//        ]
//
//        let address : Parameters = [
//              "appId":appId,
//               "unitAddress" : unitInfo["unitAddress"] as! String,
//               "latitude" : unitInfo["latitude"] as! String,
//               "longitude" : unitInfo["longitude"] as! String
//        ]
//
//        let unitInfo: Parameters = [
//            "appId":appId,
//            "unitName" : unitInfo["unitName"] as! String,
//            "udhyogAadharNo" : unitInfo["udhyogAadharNo"] as! String,
//            "unitEstDate" : unitInfo["unitEstDate"] as! String,
//            "employmentFullTime" : unitInfo["employmentFullTime"] as! String,
//            "employmentPartTime" : unitInfo["employmentPartTime"] as! String,
//            "employmentSeasonal" : unitInfo["employmentSeasonal"] as! String,
//            "noFemaleEmployees" : unitInfo["noFemaleEmployees"] as! String,
//            "noMaleEmployees" : unitInfo["noMaleEmployees"] as! String,
//            "totalEmployees" : unitInfo["total_employees"] as! String,
//
//
//        ]
//        let params : Parameters = ["data": ["unitProd":unitProd,"unitMMInfo":unitMMInfo,"unitInfo":unitInfo,"address":address]]
//
//        Alamofire.request("\(BASE_URL)\(ADDINSPECTION_URL)", method: .post, parameters:params,encoding: JSONEncoding.default).responseJSON { (response) in
//            Hud.hideLoading()
//
//            guard let value = response.result.value
//                else {
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    return }
//            let json = JSON(value)
//            print(json)
//
//            if let err = response.error{
//                onError?(err)
//                return
//            }
//
//            onCompletion!(json)
//
//        }
//
//    }
//
//
//    static func stringify(json: Any, prettyPrinted: Bool = false) -> String {
//        var options: JSONSerialization.WritingOptions = []
//        if prettyPrinted {
//            options = JSONSerialization.WritingOptions.prettyPrinted
//        }
//
//        do {
//            let data = try JSONSerialization.data(withJSONObject: json, options: options)
//            if let string = String(data: data, encoding: String.Encoding.utf8) {
//                return string
//            }
//        } catch {
//            print(error)
//        }
//
//        return ""
//    }
//
//    class func  ImageAndVideoOnServer(appId:String,imagedata: imageData, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//
//        var myJsonString = ""
//
//        if let jsonString = JSONStringEncoder().encode(imagedata) {
//
//            myJsonString = jsonString.replacingOccurrences(of: "\n", with: "")
//            print(myJsonString)
//
//        } else {
//            // Failed creating JSON string.
//        }
//
//        SingletonClassSwift.showLoading(title: UPLAOD_TITLE)
//
//        let url =  "\(BASE_URL)\(UPLOAD_URL)"
//
//        let headers: HTTPHeaders = [
//            /* "Authorization": "your_access_token",  in case you need authorization header */
//            "Content-type": "multipart/form-data"
//        ]
//
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//
//            multipartFormData.append("\(myJsonString)".data(using: String.Encoding.utf8)!, withName: "Json")
//
//            print("withname \(imagedata.name!)")
//            print("withname \(appId)")
//            print("data \(imagedata.img_videoData!)")
//
//            multipartFormData.append(imagedata.img_videoData!, withName:"photo_1", fileName:imagedata.name! , mimeType: "image/\(imagedata.type ?? "")")
//
//        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
//            switch result{
//            case .success(let upload, _, _):
//                Hud.hideLoading()
//
//                upload.responseJSON { response in
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    print("Succesfully uploaded")
//                    print("response = \(response)")
//
//                    let value = response.result.value
//                    let json = JSON(value)
//                    print(json)
//                    imagedata.uploadedID = json["data"].stringValue
//                    imagedata.isUploaded = true
//
//                    onCompletion?(nil)
//                }
//            case .failure(let error):
//                Hud.hideLoading()
//                print("Error in upload: \(error.localizedDescription)")
//                onError?(error)
//            }
//        }
//    }
    
}
//struct JSONStringEncoder {
//
//    func encode(_ dictionary: imageData) -> String? {
//
//            let jsonObject: NSMutableDictionary = NSMutableDictionary()
//            let jsonData: Data
//            jsonObject.setValue(dictionary.appID, forKey: "appId")
//            jsonObject.setValue(dictionary.type, forKey: "mediaType")
//            jsonObject.setValue(dictionary.latitude, forKey: "latitude")
//            jsonObject.setValue(dictionary.longitude, forKey: "longitude")
//            jsonObject.setValue(dictionary.attachment_name, forKey: "attachmentName")
//
//        do {
//            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
//        } catch {
//            assertionFailure("JSON data creation failed with error: \(error).")
//            return nil
//        }
//
//        guard let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) else {
//            assertionFailure("JSON string creation failed.")
//            return nil
//        }
//
//        print("JSON string: \(jsonString)")
//        return jsonString
//    }
//
//    func encodeJsonString(_ dictionary: [String: Any]) -> String? {
//        guard JSONSerialization.isValidJSONObject(dictionary) else {
//            assertionFailure("Invalid json object received.")
//            return nil
//        }
//
//        let jsonObject: NSMutableDictionary = NSMutableDictionary()
//        let jsonData: Data
//
//        dictionary.forEach { (arg) in
//            jsonObject.setValue(arg.value, forKey: arg.key)
//        }
//
//        do {
//            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
//        } catch {
//            assertionFailure("JSON data creation failed with error: \(error).")
//            return nil
//        }
//
//        guard let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) else {
//            assertionFailure("JSON string creation failed.")
//            return nil
//        }
//        return jsonString
//    }
//}
//
//
//
