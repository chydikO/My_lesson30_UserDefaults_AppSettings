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
    
    private var _switchValue: Bool
    private var _stringValue: String?
    private var _dateValue: Date?
    
    private var _userDefaults = UserDefaults.standard
    
    private enum Keys {
        static let BoolKey      = "BoolKey"
        static let StringKey    = "StringKey"
        static let DateKey      = "DateKey"
    }
    
    private init() {
        _switchValue = _userDefaults.bool(forKey: Keys.BoolKey)
        _stringValue = _userDefaults.string(forKey: Keys.StringKey)
        _dateValue = _userDefaults.object(forKey: Keys.DateKey) as? Date
    }
    
    var switchValue: Bool {
        get {
            return _switchValue
        }
        set {
            _switchValue = newValue
            _userDefaults.set(newValue, forKey: Keys.BoolKey)
        }
    }
    
    var stringValue: String? {
        get {
            return _stringValue
        }
        set {
            _stringValue = newValue
            _userDefaults.set(newValue, forKey: Keys.StringKey)
        }
    }
    
    var dateValue: Date? {
        get {
            return _dateValue
        }
        set {
            _dateValue = newValue
            _userDefaults.set(newValue, forKey: Keys.DateKey)
        }
    }
        
    func clear() {
        switchValue = false
        stringValue = nil
        dateValue = nil
    }
}
