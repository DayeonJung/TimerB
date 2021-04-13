//
//  TimerViewController.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/08.
//

import UIKit

class TimerViewController: UIViewController {

    var timerViewModel: TimerViewModelProtocol? {
        didSet {
            
            self.timerViewModel?.timeDidChage = { time in
                self.timeLabel.text = String(time)
            }
            
            self.timerViewModel?.playerDidChange = { (player) in
                self.waveView.shouldInit(with: player.color)
            }
            
        }
    }
    

    
    @IBOutlet weak var timeLabel: UILabel!
    
    var waveView: WaveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeLabel.text = String(self.timerViewModel?.currentTime ?? 99)
        
        self.initWaveView()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Timer 해제
        self.waveView.stopAnimation()
    }
    
    private func initWaveView() {
        self.waveView = WaveView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: UIScreen.main.bounds.width,
                                               height: UIScreen.main.bounds.height),
                                 bgColor: self.timerViewModel?.playerInfo.first?.color ?? UIColor.white)
        
        self.view.insertSubview(self.waveView, at: 0)
        
        self.waveView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.shouldGoNextPlayer)))
    }

    @objc func shouldGoNextPlayer() {
        self.timerViewModel?.clickedNextPlayer()
    }
    
    
}
