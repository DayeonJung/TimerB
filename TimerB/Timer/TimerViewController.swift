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
            }
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel.text = String(self.timerViewModel?.currentTime ?? 99)
        
    }
    
}
