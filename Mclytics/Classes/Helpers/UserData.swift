//
//  UserData.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation
import UIKit
//import JNKeychain

//class KeychainManager: NSObject {
//    static let sharedInstance = KeychainManager()
//    
//    func getDeviceIdentifierFromKeychain() -> String {
//        
//        // try to get value from keychain
//        var deviceUDID = self.keychain_valueForKey("keychainDeviceUDID") as? String
//        if deviceUDID == nil {
//            deviceUDID = UIDevice.current.identifierForVendor!.uuidString
//            // save new value in keychain
//            self.keychain_setObject(deviceUDID! as AnyObject, forKey: "keychainDeviceUDID")
//        }
//        return deviceUDID!
//    }
//    
//    // MARK: - Keychain
//    
//    func keychain_setObject(_ object: AnyObject, forKey: String) {
//        let result = JNKeychain.saveValue(object, forKey: forKey)
//        if !result {
//            print("keychain saving: smth went wrong")
//        }
//    }
//    
//    func keychain_deleteObjectForKey(_ key: String) -> Bool {
//        let result = JNKeychain.deleteValue(forKey: key)
//        return result
//    }
//    
//    func keychain_valueForKey(_ key: String) -> AnyObject? {
//        let value = JNKeychain.loadValue(forKey: key)
//        return value as AnyObject?
//    }
//}

// ----------------------------------------------------------
// MARK: User Data
// ----------------------------------------------------------

class UserData {
    static func saveData(value: String?, key: String) {

        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getUserData(key: String) -> String? {
        
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func storeData(value: Any, key: String) {
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: value as Any)
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
     }
    static func GetArraydata(key: String) -> NSMutableArray {
        let decodedDIC = NSMutableArray()
        let decoded  = UserDefaults.standard.object(forKey: key) as? Data
        
        if decoded != nil
        {
            let decodedTeams  = NSKeyedUnarchiver.unarchiveObject(with: decoded!)
            return decodedTeams as! NSMutableArray
        }
        return decodedDIC
    }
    static func GetDictionarydata(key: String) -> NSMutableDictionary {
        let decodedDIC = NSMutableDictionary()
        let decoded  = UserDefaults.standard.object(forKey: key) as? Data
        
        if decoded != nil
        {
            let decodedTeams  = NSKeyedUnarchiver.unarchiveObject(with: decoded!)
            return decodedTeams as! NSMutableDictionary
        }
        return decodedDIC
    }
    static func getName() -> String? {
        return UserData.getUserData(key:"Username")
    }
    static func saveName(UserName: String?) {
        saveData(value: UserName, key: "Username")
    }
    
    // ----------------------------------------------------------
    // MARK: Authentication Data
    // ----------------------------------------------------------
    
    class AuthorizationData {
        
        static func saveAuthorizationData(accessToken: String, uid: String) {
            
            UserData.saveData(value: accessToken, key: UserDataKey.Authorization.accessToken.rawValue)
            UserData.saveData(value: uid, key: UserDataKey.Authorization.uId.rawValue)
        }
        
        static func removeAuthenticationData() {
            
            UserData.saveData(value: nil, key: UserDataKey.Authorization.accessToken.rawValue)
            UserData.saveData(value: nil, key: UserDataKey.Authorization.uId.rawValue)
        }
        
        static func getAccessToken() -> String? {
            
            return UserData.getUserData(key: UserDataKey.Authorization.accessToken.rawValue)
        }
        
        static func getClient() -> String? {
            
            return UIDevice.current.identifierForVendor?.uuidString
        }
        
        static func getUId() -> String? {
            
            return UserData.getUserData(key: UserDataKey.Authorization.uId.rawValue)
        }
    
        static func isLogged() -> Bool {
            
            if self.getAccessToken() != nil, self.getUId() != nil {
                return true
            }
            return false
        }
    }
    
}
