//
//  List.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import Foundation
import UIKit


extension UICollectionView {
    
    enum ReuseType {
        case Header
        case Footer
    }
    
    func loadCell<T>(identifier:T.Type, indexPath:IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: identifier), for: indexPath) as! T
    }
    
    func loadReusableView<T>(type:ReuseType, identifier:T.Type, indexPath:IndexPath) -> T {
        
        var reuseView = UICollectionView.elementKindSectionHeader
        
        if type == .Footer {
            reuseView = UICollectionView.elementKindSectionFooter
        }
    
        return self.dequeueReusableSupplementaryView(ofKind: reuseView, withReuseIdentifier: String(describing: identifier), for: indexPath) as! T
    }
    
    func setCell(cellName:UICollectionViewCell.Type) {
        self.register(UINib(nibName: String(describing: cellName), bundle: nil), forCellWithReuseIdentifier: String(describing: cellName))
    }
    
    func setReusableView(viewName:UICollectionReusableView.Type, viewType:ReuseType) {
        var reuseView = UICollectionView.elementKindSectionHeader
        
        if viewType == .Footer {
            reuseView = UICollectionView.elementKindSectionFooter
        }
        self.register(UINib(nibName: String(describing: viewName), bundle: nil), forSupplementaryViewOfKind: reuseView, withReuseIdentifier: String(describing: viewName))
    }
    
}


extension UITableView {
    
    func loadCell<T>(identifier:T.Type, indexPath:IndexPath? = nil) -> T {
        
        if let path = indexPath {
           return self.dequeueReusableCell(withIdentifier: String(describing: identifier), for: path) as! T
        }
        
        return self.dequeueReusableCell(withIdentifier: String(describing: identifier)) as! T
    }
    
    
    func setCell(cellName:UITableViewCell.Type) {
        self.register(UINib(nibName: String(describing: cellName), bundle: nil), forCellReuseIdentifier: String(describing: cellName))
    }
    
    
}
