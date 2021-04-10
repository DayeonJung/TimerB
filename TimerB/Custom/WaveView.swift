//
//  WaveView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/10.
//

import Foundation
import UIKit

class WaveView: UIView {
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    var path = UIBezierPath()
    var waveLayer = CAShapeLayer()

    var points = [CGPoint]()
    var zeroYPoint: CGFloat = UIScreen.main.bounds.width/2
    var amplitude: CGFloat = 10
    
    var shouldUpdate: Bool = false {
        didSet {
            
            let newPoints = self.moveRightNextValue()
            
            UIView.animate(withDuration: 2) {
                self.path = self.setPath(newPoints)
                self.waveLayer.path = self.path.cgPath

//                self.setNeedsDisplay()

            } completion: { (_) in
                self.points = newPoints
                self.shouldUpdate = true
            }

        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    
    
    func commoninit() {
        
        let space: CGFloat = 1
        var currentX: CGFloat = 0
        
        while currentX < self.width {
            self.points.append(CGPoint(x: currentX,
                                  y: zeroYPoint + self.amplitude * sin(currentX * 4 * .pi / self.width)))
            currentX += space
        }
        
        
        self.path = self.setPath(self.points)
        self.waveLayer.path = self.path.cgPath
        self.waveLayer.fillColor = UIColor.blue.cgColor
        
        self.layer.addSublayer(self.waveLayer)

    }
    
    override func draw(_ rect: CGRect) {
        
    
    }
    
    func setPath(_ points: [CGPoint]) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        let first = points.first ?? CGPoint(x: 0, y: self.height)
        
        path.move(to: CGPoint(x: first.x, y: first.y))
        for point in points where point != points.first {
            path.addLine(to: point)
        }
        path.addLine(to: CGPoint(x: self.width, y: self.height))
        path.addLine(to: CGPoint(x: 0, y: self.height))

        return path
    }
    
    func moveRightNextValue() -> [CGPoint] {
        
        return self.points.enumerated().map({ (idx, point) -> CGPoint in
            if idx == self.points.endIndex - 1 {
                return CGPoint(x: point.x,
                               y: self.points[0].y)
            } else {
                return CGPoint(x: point.x,
                               y: self.points[idx + 1].y)
            }
        })
        
    }
    
}
