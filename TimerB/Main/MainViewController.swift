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
    
    var settingContainer: SettingManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainList.setCell(cellName: SelectOptionCell.self)
        self.mainList.setCell(cellName: StartGameCell.self)
        
        self.mainList.setCell(cellName: RecentCell.self)
        self.mainList.setReusableView(viewName: TitleHeader.self,
                                      viewType: .Header)

        self.settingContainer = SettingManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let saved = RecentManager.recentOptions()
        self.mainViewModel.savedOptions = saved
        self.mainList.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.settingContainer.passPlayerInfos(with: [])
    }
    
    private func moveToNextPage() {
        
        let timerVC = getController(with: .Main,
                      viewController: TimerViewController.self)
        let timeVM = self.mainViewModel.setTimeViewModel()
        
        timerVC.timerViewModel = timeVM
        self.settingContainer.delegate = timerVC
        self.settingContainer.passPlayerInfos(with: timeVM.playerInfo)
        self.mainViewModel.saveAsRecentOption(with: timeVM)
        self.navigationController?.pushViewController(timerVC, animated: true)

    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.mainViewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainViewModel.sectionType(with: section) == .SetOptions ? 3 : self.mainViewModel.savedOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = self.mainViewModel.sectionType(with: indexPath.section)
        switch type {
        case .SetOptions:
            if indexPath.item == 2 {
                let startCell = collectionView.loadCell(identifier: StartGameCell.self, indexPath: indexPath)
                
                startCell.startButton.onClick = {
                    self.moveToNextPage()
                }
                
                return startCell
            }
            
            let cell = collectionView.loadCell(identifier: SelectOptionCell.self, indexPath: indexPath)
            cell.setViewModel(with: self.mainViewModel.options[indexPath.item])
            
            cell.passAlertViewToController = { alertVC in
                self.present(alertVC, animated: true, completion: nil)
            }
            
            return cell
            
        case .Recent:
            let recentCell = collectionView.loadCell(identifier: RecentCell.self, indexPath: indexPath)
            recentCell.setUI(with: self.mainViewModel.savedOptions[indexPath.item])
            return recentCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let type = self.mainViewModel.sectionType(with: section)
        switch type {
        case .SetOptions:
            return .zero
        case .Recent:
            return CGSize(width: UIScreen.main.bounds.width, height: 52)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let type = self.mainViewModel.sectionType(with: indexPath.section)
        if type == .Recent {
            let header = collectionView.loadReusableView(type: .Header,
                                                         identifier: TitleHeader.self,
                                                         indexPath: indexPath)
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = self.mainViewModel.sectionType(with: indexPath.section)
        
        if type == .Recent {
            self.mainViewModel.setOptionInfo(with: indexPath.item)
            self.moveToNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let type = self.mainViewModel.sectionType(with: section)
        
        switch type {
        case .SetOptions:
            return UIEdgeInsets(top: 36,
                                left: 0,
                                bottom: 86,
                                right: 0)
        case .Recent:
            return UIEdgeInsets(top: 0,
                                left: 20,
                                bottom: 0,
                                right: 20)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let type = self.mainViewModel.sectionType(with: section)
        
        switch type {
        case .SetOptions:
            return 30
        case .Recent:
            return 12
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let type = self.mainViewModel.sectionType(with: indexPath.section)
        
        switch type {
        case .SetOptions:
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        case .Recent:
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 60)
        }

    }

}
