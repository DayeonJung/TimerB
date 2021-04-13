//
//  TimerViewModel.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/08.
//

import Foundation
import UIKit

protocol TimerViewModelProtocol {
    var playerInfo: [PlayerInfo] { get set }
    var currentTime: Int { get }
    var timeDidChage: ((Int) -> ())? { get set }
    var playerDidChange: ((PlayerInfo) -> ())? { get set }
    func timeIsGoing()
    func clickedNextPlayer()
}

class TimerViewModel: TimerViewModelProtocol {

    private var maxTime: Int
    var currentTime: Int {
        didSet {
            self.timeDidChage?(self.currentTime)
        }
    }
    
    var playerInfo: [PlayerInfo]
    
    private var timer: Timer?
    var timeDidChage: ((Int) -> ())?

    var currentPlayerIdx: Int = 0 {
        didSet {
            self.currentTime = self.maxTime
            self.playerDidChange?(self.playerInfo[self.currentPlayerIdx])
        }
    }
    var playerDidChange: ((PlayerInfo) -> ())?

    
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

    @objc func timeIsGoing() {
        
        let nextTime = self.currentTime - 1
        
        if nextTime < 0 {
            self.currentTime = self.maxTime
        } else {
            self.currentTime = nextTime
        }

    }
    
    func clickedNextPlayer() {
        let idx = self.currentPlayerIdx + 1
        self.currentPlayerIdx = idx >= self.playerInfo.count ? 0 : idx
    }
}
