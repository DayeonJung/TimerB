//
//  SettingManager.swift
//  TimerB
//
//  Created by 정다연 on 2021/05/10.
//

import Foundation


class NoticeManager {
    
    private static let SOUND_ON = "soundOn"
    private static let VIBRATION_ON = "vibrationOn"
    
    static let userDefaults = UserDefaults.standard
    
    class func notice(keyString: String) -> Bool {
        
        return userDefaults.bool(forKey: keyString)
        
    }
    
    
    class func saveNotice(key: String, value: Bool) {
        
        userDefaults.set(value, forKey: key)
        
    }
    
}
