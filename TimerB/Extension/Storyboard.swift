//
//  Storyboard.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/08.
//

import Foundation
import UIKit

enum StoryboardName:String {
    case Main = "Main"
}

func getController<T>(with storyboard: StoryboardName, viewController: T.Type) -> T {
    
    let controller = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: String(describing: viewController)) as! T
    
    return controller
    
}
