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

let BASE_URL = "https://mclytics.com/api/"
let LOGIN_URL = "login"
let FORMS_URL = "forms"
let SUBMIT_URL = "forms/formid/submit"


class WebServicesManager {
    
    class func login(email:String, password:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [
            CS.Params.email: email,
            CS.Params.password: password
        ]
        print("\(BASE_URL)\(LOGIN_URL)")
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

//    class func getForm(page:Int, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
//
//        Hud.showLoading(title: CS.Common.waiting)
//
//        let header: HTTPHeaders = [
//            "Authorization": "Bearer \(ParentClass.sharedInstance.token ?? "")",
//            "Accept": "application/json"
//        ]
//        print(header)
//        let str_url = "\(BASE_URL)\(FORMS_URL)?\(CS.Params.page)=\(page)"
//        print(str_url)
//
//        Alamofire.request(str_url ,encoding: JSONEncoding.default ,headers: header).responseJSON { (response) in
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
//            onCompletion!(json)
//
//        }
//
//    }
    
    
    class func getForm(page:Int, andCompletion completion: @escaping (_ isSuccess: Bool, _ data: NSDictionary) -> Void, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)
        
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(ParentClass.sharedInstance.token ?? "")",
            "Accept": "application/json"
        ]
        print(header)
        let str_url = "\(BASE_URL)\(FORMS_URL)?\(CS.Params.page)=\(page)"
        print(str_url)
        
        Alamofire.request(str_url ,encoding: JSONEncoding.default ,headers: header).responseJSON { (response) in
            Hud.hideLoading()
            
            if let err = response.error{
                onError?(err)
                return
            }
            
            switch response.result {
            case .success(let JSON):
                let dictJSON = JSON as! NSDictionary
                completion(true, dictJSON)
            case .failure( _):
                completion(false, NSDictionary())
            }
        }
    }

    class func formSubmit(formData:Parameters,fromId :Int, andCompletion completion: @escaping (_ isSuccess: Bool, _ data: NSDictionary) -> Void, onError: ((Error?) -> Void)? = nil) {
    
    Hud.showLoading(title: CS.Common.waiting)
    
    let header: HTTPHeaders = [
        "Authorization": "Bearer \(ParentClass.sharedInstance.token ?? "")",
        "Accept": "application/json",
        "Content-type": "multipart/form-data"
    ]
    
    print(header)
    let str_url = "\(BASE_URL)forms/\(fromId)/submit"
    print(str_url)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in formData {
                if let imageData = value as? AGImageInfo {
                    multipartFormData.append(imageData.data, withName: key, fileName: imageData.fileName, mimeType: imageData.type)
                }
               
                multipartFormData.append("\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)

            }
            
        }, to: str_url, method: .post, headers: header) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        Hud.hideLoading()
                        let dictJSON = value as! NSDictionary
                        print(dictJSON)
                        completion(true, dictJSON)
                        break
                    case .failure(let error):
                        Hud.hideLoading()
                        debugPrint(error)
                        completion(false, NSDictionary())
                        break
                    }
                }
                
            case .failure(let error):
                Hud.hideLoading()
                debugPrint(error)
                completion(false, NSDictionary())
                break
            }
        }
    }
}


