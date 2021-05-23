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
    func shouldGoToNextPlayer(to: Direction)
    func getMaxTime() -> Int
    func shouldUpdatePlayerInfos(with: [PlayerInfo])
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
            self.shouldGoToNextPlayer(to: .Next)
        } else {
            self.currentTime = nextTime
        }

    }
    
    func shouldGoToNextPlayer(to: Direction) {
        
        var idx = self.currentPlayerIdx
        
        switch to {
        case .Next:
            idx += 1
            self.currentPlayerIdx = idx >= self.playerInfo.count ? 0 : idx

        case .Back:
            idx -= 1
            self.currentPlayerIdx = idx < 0 ? self.playerInfo.count - 1 : idx
        }

    }
    
    func getMaxTime() -> Int {
        return self.maxTime
    }
    
    
    
    func shouldUpdatePlayerInfos(with data: [PlayerInfo]) {
        
        // 타이머를 재시작할 멤버는?
        // 1순위 : 현재 카운트다운하고 있는 player
        // 2순위 : 1순위가 삭제되어 없을 경우, 현재 존재하는 player 중 다음 순서.

        var idxToRestart = 0
        var dataIndexChanged = data
        let currentPlayer = self.playerInfo[self.currentPlayerIdx]
        
        
        // 현재 플레이어가 남아있을 경우 그대로 보여준다.
        if let playerIdx = data.firstIndex(where: {$0 == currentPlayer}) {
            
            idxToRestart = playerIdx
            
        } else {
            
            // 현재 존재하는 player 중 다음 순서의 인덱스 저장.
            for (currentIdx, info) in data.enumerated() {
                
                if info.index > self.currentPlayerIdx {
                    idxToRestart = currentIdx
                    break
                }
                
            }
            
            // 바뀐 순서대로 0부터 인덱스 조정
            dataIndexChanged = dataIndexChanged.enumerated().map { (index, info) -> PlayerInfo in
                return PlayerInfo(index: index,
                                  color: info.color,
                                  name: info.name)
            }
            
        }
        
        
        self.playerInfo = dataIndexChanged
        self.currentPlayerIdx = idxToRestart
        self.shouldStop = false


    }
    
    
}
