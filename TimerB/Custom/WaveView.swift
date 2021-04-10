//
//  WaveView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/10.
//

import Foundation
import UIKit

class WaveView: UIView, CAAnimationDelegate {
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    var path = UIBezierPath()
    var waveLayer = CAShapeLayer()

    var points = [CGPoint]()
    var zeroYPoint: CGFloat = UIScreen.main.bounds.height - 120
    var amplitude: CGFloat = 8
    
    var shouldUpdate: Bool = false {
        didSet {
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
        
        let spaceBetweenX: CGFloat = 1
        var currentX: CGFloat = 0
        
        while currentX < self.width {
            self.points.append(CGPoint(x: currentX,
                                       y: zeroYPoint + self.amplitude * sin(currentX * 2 * .pi / self.width)))
            currentX += spaceBetweenX
        }

        self.path = self.setPath(self.points)
        self.waveLayer.path = self.path.cgPath
        self.waveLayer.fillColor = UIColor.blue.cgColor
        self.layer.addSublayer(self.waveLayer)

        
    }
    
    override func draw(_ rect: CGRect) {
        let newPoints = self.movingOneStepPoints()
        let newPath = self.setPath(newPoints)
        let newCGPath = newPath.cgPath

        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = self.waveLayer.path
        animation.toValue = newCGPath
        animation.delegate = self

        self.waveLayer.add(animation, forKey: "path")
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.points = self.movingOneStepPoints()
        self.path = self.setPath(self.points)
        self.waveLayer.path = self.path.cgPath
        setNeedsDisplay()
    }
    
    
    func setPath(_ points: [CGPoint]) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        let first = points.first ?? CGPoint(x: 0, y: self.height)
        path.move(to: CGPoint(x: first.x, y: first.y))
        
        for point in points where point != points.first {
            path.addLine(to: point)
        }
        
        // 오른쪽 아래 포인트
        path.addLine(to: CGPoint(x: self.width, y: self.height))
        
        // 왼쪽 아래 포인트
        path.addLine(to: CGPoint(x: 0, y: self.height))

        return path
    }
    
    func movingOneStepPoints() -> [CGPoint] {
        
        return self.points.enumerated().map({ (idx, point) -> CGPoint in
            var yToMove =
                point == self.points.last ?
                self.points[0].y :
                self.points[idx + 1].y
            let xToMove =
                point == self.points.last ?
                self.width :
                point.x
                
            yToMove -= 0.05
            return CGPoint(x: xToMove, y: yToMove)
        })
        
    }
    
}
