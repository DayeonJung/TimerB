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
            self.timerViewModel?.timeDidChage = { vm in
                self.timeLabel.text = String(vm.currentTime)
                if !self.shouldUpdate {
//                    self.shouldUpdate = true
                }
            }
        }
    }
    
    var shouldUpdate: Bool = false {
        didSet {
//            self.waveView.shouldUpdate = true
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
//    let waveView = WaveView(frame: CGRect(x: 0,
//                                          y: 0,
//                                          width: UIScreen.main.bounds.width,
//                                          height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel.text = String(self.timerViewModel?.currentTime ?? 99)
        
//        self.view.addSubview(self.waveView)
    }
    
}
