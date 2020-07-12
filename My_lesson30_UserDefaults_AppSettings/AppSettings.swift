//
//  AppSettings.swift
//  My_lesson30_UserDefaults_AppSettings
//
//  Created by Олег Чудновский on 12.07.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import Foundation

// SinglTone
class AppSettings {
    
    static let shared = AppSettings()
    
    private enum Keys {
        static let BoolKey = "BoolKey"
        static let StringKey = "StringKey"
        static let DateKey = "DateKey"
    }
    
    private init() {}
    
    var switchValue: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.BoolKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.BoolKey)
        }
    }
    
    var stringValue: String? {
        get {
            return UserDefaults.standard.value(forKey: Keys.StringKey) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.StringKey)
        }
    }
    
    var dateValue: Date? {
        get {
            return UserDefaults.standard.value(forKey: Keys.DateKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.DateKey)
        }
    }
        
    func clear() {
        switchValue = false
        stringValue = nil
        dateValue = nil
    }
    
}
