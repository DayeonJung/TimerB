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
    var shouldStop: Bool { get set }
    var timerStop: ((Bool) -> ())? { get set }
    func shouldGoToNextPlayer()
    func getMaxTime() -> Int
}

class TimerViewModel: TimerViewModelProtocol {
    

    var playerInfo: [PlayerInfo]

    private let maxTime: Int
    var currentTime: Int {
        didSet {
            self.timeDidChage?(self.currentTime)
        }
    }
        
    private var timer = Timer()
    var timeDidChage: ((Int) -> ())?
    var timerStop: ((Bool) -> ())?

    
    var shouldStop: Bool = false {
        didSet {
            if self.shouldStop {
                self.stopTimer()
            } else {
                self.startTimer()
            }
            
            self.timerStop?(self.shouldStop)
        }
    }
    

    private var currentPlayerIdx: Int = 0 {
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
        
        self.startTimer()
    }
    
    private func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(timeIsGoing),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    private func stopTimer() {
        self.timer.invalidate()
    }

    @objc private func timeIsGoing() {
        
        let nextTime = self.currentTime - 1
        
        if nextTime <= 0 {
            self.currentTime = self.maxTime
            self.shouldGoToNextPlayer()
        } else {
            self.currentTime = nextTime
        }

    }
    
    func shouldGoToNextPlayer() {
        let idx = self.currentPlayerIdx + 1
        self.currentPlayerIdx = idx >= self.playerInfo.count ? 0 : idx
    }
    
    func getMaxTime() -> Int {
        return self.maxTime
    }
}
