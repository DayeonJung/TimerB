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
    
    var sections: [MainSection]
    var options: [SelectOptionViewModel]
    
    init() {
        self.sections = [.SetOptions]
        self.options = [
            SelectOptionViewModel(model: OptionModel(type: .Player,
                                                     value: 2)),
            SelectOptionViewModel(model: OptionModel(type: .Time,
                                                     value: 99))
        ]
    }
    
    private func optionInfo(with type: Option) -> SelectOptionViewModel {
        return self.options.filter({$0.option.currentType() == type}).first ?? self.options.first!
    }
    
    func setTimeViewModel() -> TimerViewModel {
        let playerNum = self.optionInfo(with: .Player).option.currentValue()
        
        let playerInfos = Array(0..<playerNum).map({ num -> PlayerInfo in
            return PlayerInfo(color: self.colorSet[num], name: "player" + String(num + 1))
        })

        return TimerViewModel(time: self.optionInfo(with: .Time).option.currentValue(),
                              player: playerInfos)
    }
    
}
