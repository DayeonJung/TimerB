//
//  MainViewController.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainList: UICollectionView!
    
    var mainViewModel = MainViewModel()
    
    var settingContainer: SettingContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainList.setCell(cellName: SelectOptionCell.self)
        self.mainList.setCell(cellName: StartGameCell.self)
        
        self.settingContainer = SettingContainerView()
    }
    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.mainViewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2 {
            let startCell = collectionView.loadCell(identifier: StartGameCell.self, indexPath: indexPath)
            
            startCell.startButton.onClick = {
                
                let timerVC = getController(with: .Main,
                              viewController: TimerViewController.self)
                timerVC.timerViewModel = self.mainViewModel.setTimeViewModel()
                self.navigationController?.pushViewController(timerVC, animated: true)
            }
            
            return startCell
        }
        
        let cell = collectionView.loadCell(identifier: SelectOptionCell.self, indexPath: indexPath)
        cell.setViewModel(with: self.mainViewModel.options[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 36,
                            left: 0,
                            bottom: 86,
                            right: 0)
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: .mainWidth, height: 60)
    }
}
