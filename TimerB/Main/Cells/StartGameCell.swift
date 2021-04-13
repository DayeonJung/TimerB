//
//  StartGameCell.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/06.
//

import UIKit

class StartGameCell: UICollectionViewCell {

    @IBOutlet weak var startButton: TitleButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.startButton.setModel(
            with: TitleButtonModel(title: "Game Start",
                                   titleColor: .white,
                                   bgColor: UIColor.systemPink)
        )
    }

}
