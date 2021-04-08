//
//  MainViewModel.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import Foundation

class MainViewModel {
    
    var sections: [MainSection]
    var options: [SelectOptionViewModel]
    
    init() {
        self.sections = [.SetOptions]
        self.options = [
            SelectOptionViewModel(model: OptionModel(type: .Player,
                                                     value: 0)),
            SelectOptionViewModel(model: OptionModel(type: .Time,
                                                     value: 99))
        ]
    }
    
}
