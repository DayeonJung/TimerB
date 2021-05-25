//
//  NoticeManager.swift
//  TimerB
//
//  Created by 정다연 on 2021/05/10.
//

import Foundation
import AVFoundation


class NoticeManager {
    
    enum NoticeKey: Int {
        case SOUND = 0
        case VIBRATION = 1
        
        var keyString: String {
            switch self {
            case .SOUND:
                return "sound"
            case .VIBRATION:
                return "vibration"
            }
        }
    }
    
    var alertSound: AVAudioPlayer?

    private let userDefaults = UserDefaults.standard
    
    private var soundIsOn: Bool {
        return self.notice(key: NoticeKey.SOUND)
    }
    private var vibrationIsOn: Bool {
        return self.notice(key: NoticeKey.VIBRATION)
    }
    
    init() {
        
        self.initSound()
        
    }
    
    private func initSound() {
        
        let path = Bundle.main.path(forResource: "alert", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            self.alertSound = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("couldn't load file :(")
        }
        
    }
    
    
    func notice(key: NoticeKey) -> Bool {
        
        return userDefaults.bool(forKey: key.keyString)
        
    }
    
    
    func setNotice(key: NoticeKey, value: Bool? = nil) -> Bool {
        let val = value == nil ? !self.notice(key: key) : value!
        userDefaults.set(val, forKey: key.keyString)
        
        // 활성화시킬 때 해당 효과음 실행.
        if val {
            switch key {
            case .SOUND:
                self.playSound()
            case .VIBRATION:
                self.playVibration()
            }
        }
        
        return val
    }
    

    func notifyIfNeeded() {
        
        if self.soundIsOn {
            self.playSound()
        }
        
        if self.vibrationIsOn {
            self.playVibration()
        }
        
    }
    
    
    private func playSound() {
        self.alertSound?.play()

    }
    
    
    private func playVibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
}
