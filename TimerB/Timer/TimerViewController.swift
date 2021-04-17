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
            
            self.timerViewModel?.playerDidChange = { player in
                self.waveView.shouldInit(with: player.color)
            }
            
            self.timerViewModel?.timerStop = { state in
                self.waveView.shouldStop = state
            }
        }
    }
    

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: IconButton!
    
    var waveView: WaveView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeLabel.text = String(self.timerViewModel?.currentTime ?? 99)
        
        self.initWaveView()
        self.setBottomButtonsUI()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Timer 해제
        self.timerViewModel?.shouldStop = true
    }
    
    private func initWaveView() {
        self.waveView = WaveView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: UIScreen.main.bounds.width,
                                               height: UIScreen.main.bounds.height),
                                 bgColor: self.timerViewModel?.playerInfo.first?.color ?? UIColor.white,
                                 maxTime: self.timerViewModel?.getMaxTime() ?? 99)
        
        self.view.insertSubview(self.waveView, at: 0)
        
        self.waveView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didClickBackground)))
    }

    @objc private func didClickBackground() {
        self.timerViewModel?.shouldGoToNextPlayer()
    }
    

    private func setBottomButtonsUI() {
        self.playButton.setModel(with: IconButtonModel(imageName: .Play, bgColor: .white, tintColor: UIColor(named: "Background")!))
        
        self.playButton.onClick = {
            let state = self.timerViewModel?.shouldStop ?? false
            self.timerViewModel?.shouldStop = !state
        }
    }
    
}
