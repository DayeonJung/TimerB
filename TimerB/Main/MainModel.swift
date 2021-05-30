//
//  MainModel.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import Foundation
import UIKit

enum MainSection {
    case SetOptions
    case Recent
}


class RecentManager {
    
    static let userDefaults = UserDefaults.standard

    private static let RECENT_KEY = "recent"
        
    class func recentOptions() -> [RecentOption] {
        
        guard let data = self.userDefaults.object(forKey: RECENT_KEY) as? Data else { return [] }
        
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [RecentOption] ?? []
        
    }
    
    class func saveRecentOption(with data: RecentOption) {
        
        var saved = self.recentOptions()
        saved.removeAll(where: { $0.time == data.time && $0.player == data.player })
        
        if saved.count >= 10 { saved.removeLast() }
        
        saved.insert(data, at: 0)
        
        do {
            let archived = try NSKeyedArchiver.archivedData(withRootObject: saved, requiringSecureCoding: false)
            self.userDefaults.set(archived, forKey: RECENT_KEY)
            
        } catch {
            print("Recent Data를 저장할 수 없습니다.")
        }
        
    }
    
    
}


class RecentOption : NSObject, NSCoding {
    
    var color: UIColor
    var time: Int
    var player: Int

    init(_ color: UIColor,
         _ time: Int,
         _ player: Int) {
        self.color = color
        self.time = time
        self.player = player
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.color, forKey: "color")
        coder.encode(self.time, forKey: "time")
        coder.encode(self.player, forKey: "player")
    }
    
    required convenience init?(coder: NSCoder) {
        let color = coder.decodeObject(forKey: "color") as! UIColor
        let time = coder.decodeInteger(forKey: "time")
        let player = coder.decodeInteger(forKey: "player")
        
        self.init(color,
                  time,
                  player)

    }
    
}
