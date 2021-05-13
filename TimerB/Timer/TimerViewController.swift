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
                self.timeLabel.textColor = time <= 3 ? .systemRed : .white
            }
            
            self.timerViewModel?.playerDidChange = { player in
                self.waveView.shouldInit(with: player.color)
            }
            
            self.timerViewModel?.timerStop = { state in
                let iconName = state ? Icon.Play.rawValue : Icon.Pause.rawValue
                self.playButton.setImage(UIImage(systemName: iconName), for: .normal)
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
        
//        self.initSettingTopView()
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
                                               width: .mainWidth,
                                               height: .mainHeight),
                                 bgColor: self.timerViewModel?.playerInfo.first?.color ?? UIColor.white,
                                 maxTime: self.timerViewModel?.getMaxTime() ?? 99)
        
        self.view.insertSubview(self.waveView, at: 0)
        
        self.waveView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didClickBackground)))
    }
    
    @objc private func didClickBackground() {
        self.timerViewModel?.shouldGoToNextPlayer(to: .Next)
    }
    

    private func setBottomButtonsUI() {
        self.playButton.setModel(with: IconButtonModel(imageName: .Pause,
                                                       bgColor: .white,
                                                       tintColor: UIColor.background))
        
        self.playButton.onClick = {
            let state = self.timerViewModel?.shouldStop ?? false
            self.timerViewModel?.shouldStop = !state
        }
        
        
    }
    
    
    @IBAction func didTapChangePlayer(_ sender: UIButton) {
        
        self.timerViewModel?.shouldGoToNextPlayer(to: sender.tag == 0 ? .Back : .Next)
        
    }
    
    
}
