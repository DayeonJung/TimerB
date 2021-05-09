//
//  MainViewModel.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import Foundation
import UIKit

class MainViewModel {
    
    let colorSet: [UIColor] = [.systemRed,
                               .systemOrange,
                               .systemYellow,
                               .systemGreen,
                               .systemTeal,
                               .systemBlue,
                               .systemIndigo,
                               .systemPurple,
                               .systemPink]
    
    private var sections: [MainSection]
    var options: [SelectOptionViewModel]
    var savedOptions: [RecentOption] = [] {
        didSet(oldValue) {
            if oldValue != self.savedOptions {
                self.setRecentSection()
            }
        }
        
    }
    
    init() {
        self.sections = [.SetOptions]
        self.options = [
            SelectOptionViewModel(model: OptionModel(type: .Time,
                                                     value: 30)),
            SelectOptionViewModel(model: OptionModel(type: .Player,
                                                     value: 4))
        ]
        
        self.savedOptions = RecentManager.recentOptions()
        
        
    }
    
    private func setRecentSection() {
        
        if self.savedOptions.isEmpty {
            self.sections.removeAll(where: {$0 == .Recent})
        } else {
            if !self.sections.contains(.Recent) {
                self.sections.append(.Recent)
            }
        }
        
    }
    
    func numberOfSections() -> Int {
        return self.sections.count
    }
    
    func sectionType(with index: Int) -> MainSection {
        return self.sections[index]
    }
    
    
    private func optionInfo(with type: Option) -> SelectOptionViewModel {
        return self.options.filter({$0.option.currentType() == type}).first ?? self.options.first!
    }
    
    func setTimeViewModel() -> TimerViewModel {
        let playerNum = self.optionInfo(with: .Player).option.currentValue()
        
        let playerInfos = Array(0..<playerNum).map({ num -> PlayerInfo in
            return PlayerInfo(color: self.colorSet[num], name: "player " + String(num + 1))
        })
        
        return TimerViewModel(time: self.optionInfo(with: .Time).option.currentValue(),
                              player: playerInfos)
    }
    
    func saveAsRecentOption(with model: TimerViewModel) {
        
        let recent = RecentOption(self.colorSet.randomElement() ?? UIColor(),
                                  model.getMaxTime(),
                                  model.playerInfo.count)
        RecentManager.saveRecentOption(with: recent)
    }
    
    func setOptionInfo(with index: Int) {
        
        self.optionInfo(with: .Player).option.setValue(with: self.savedOptions[index].player)
        self.optionInfo(with: .Time).option.setValue(with: self.savedOptions[index].time)

    }
    
}
