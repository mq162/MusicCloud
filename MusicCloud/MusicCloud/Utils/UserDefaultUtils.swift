//
//  UserDefaultUtils.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/04/2021.
//

import Foundation

protocol UserDefaultUtilsProtocol {
    func checkKey(suiteName:String, key:String) -> Bool
    func removeKey(suiteName:String, key:String)
    func setString(suiteName:String, value:String, key:String)
    func setInterger(suiteName:String, value:Int, key:String)
    func stringValue(suiteName:String, key:String) -> String!
    func intValue(suiteName:String, key:String) -> Int?
    func setBool(value:Bool,key:String)
    func boolValue(key:String) ->Bool
}

class UserDefaultUtils: UserDefaultUtilsProtocol {
    func checkKey(suiteName:String = "", key:String) -> Bool {
        let defaults = suiteName.isEmpty ? UserDefaults.standard : UserDefaults(suiteName: suiteName)
        if defaults?.object(forKey: key) != nil {
            return true
        }
        return false
    }
    
    func removeKey(suiteName:String = "", key:String) {
        let defaults = suiteName.isEmpty ? UserDefaults.standard : UserDefaults(suiteName: suiteName)
        if defaults?.object(forKey: key) != nil {
            defaults?.removeObject(forKey: key)
            defaults?.synchronize()
        }
    }
    
    func setString(suiteName:String = "", value:String, key:String) {
        let defaults = suiteName.isEmpty ? UserDefaults.standard : UserDefaults(suiteName: suiteName)
        defaults?.set(value, forKey: key)
        defaults?.synchronize()
    }
    
    func setInterger(suiteName:String = "", value:Int, key:String) {
        let defaults = suiteName.isEmpty ? UserDefaults.standard : UserDefaults(suiteName: suiteName)
        defaults?.set(value, forKey: key)
        defaults?.synchronize()
    }
    
    func stringValue(suiteName:String = "", key:String) -> String! {
        let defaults = suiteName.isEmpty ? UserDefaults.standard : UserDefaults(suiteName: suiteName)
        return defaults?.string(forKey: key)
    }
    
    func intValue(suiteName:String = "", key:String) -> Int? {
        let defaults = suiteName.isEmpty ? UserDefaults.standard : UserDefaults(suiteName: suiteName)
        return defaults?.integer(forKey: key)
    }
    
    func setBool(value:Bool,key:String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    func boolValue(key:String) ->Bool{
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
}
