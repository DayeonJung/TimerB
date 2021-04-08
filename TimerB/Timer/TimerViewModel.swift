//
//  TimerViewModel.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/08.
//

import Foundation

protocol TimerViewModelProtocol {
    var currentTime: Int { get }
    func timeIsGoing()
    var timeDidChage: ((TimerViewModelProtocol) -> ())? { get set }
}

class TimerViewModel {

    private var maxTime: Int
    var currentTime: Int {
        didSet {
            self.timeDidChage?(self)
        }
    }
    private var playerInfo: [PlayerInfo]
    
    private var timer: Timer?
    var timeDidChage: ((TimerViewModelProtocol) -> ())?

    
    init(time: Int, player: [PlayerInfo]) {
        self.maxTime = time
        self.currentTime = time
        self.playerInfo = player
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(timeIsGoing),
                                          userInfo: nil,
                                          repeats: true)
    }

    
}

extension TimerViewModel: TimerViewModelProtocol {
    
    @objc func timeIsGoing() {
        
        let nextTime = self.currentTime - 1
        
        if nextTime < 0 {
            self.currentTime = self.maxTime
        } else {
            self.currentTime = nextTime
        }

    }
    
    
}
