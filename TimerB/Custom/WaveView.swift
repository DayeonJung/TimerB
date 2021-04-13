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

    var frontPoints = [CGPoint]() {
        didSet {
            self.frontWaveLayer.path = self.path(from: self.frontPoints).cgPath
        }
    }
    var frontWaveLayer = CAShapeLayer()
    
    var backPoints = [CGPoint]() {
        didSet {
            self.backWaveLayer.path = self.path(from: self.backPoints).cgPath
        }
    }
    var backWaveLayer = CAShapeLayer()

    
    
    var zeroYPoint: CGFloat = 0
    var amplitude: CGFloat = 13
    var drawPeriod: Double = 0.002
    
    var timer = Timer()
    
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
        
        self.frontPoints = self.makePointsToDraw()
        self.frontWaveLayer.fillColor = UIColor.blue.cgColor
        self.layer.addSublayer(self.frontWaveLayer)
        
        self.backPoints = self.makePointsToDraw(delay: 2 * .pi/4)
        self.backWaveLayer.fillColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        self.layer.insertSublayer(self.backWaveLayer, at: 0)
        
        self.startAnimation()

    }
    
    override func draw(_ rect: CGRect) {
        
        self.frontPoints = self.movingOneStepPoints(points: self.frontPoints)
        self.backPoints = self.movingOneStepPoints(points: self.backPoints)

    }

    
    private func makePointsToDraw(delay: CGFloat = 0) -> [CGPoint] {
        
        var points = [CGPoint]()
        let spaceBetweenX: CGFloat = 1
        var currentX: CGFloat = 0
        
        while currentX < self.width {
            points.append(CGPoint(x: currentX,
                                            y: zeroYPoint + self.amplitude * sin(delay + currentX * 2 * .pi / self.width)))
            currentX += spaceBetweenX
        }
        
        return points
    }
    
    private func startAnimation() {
        self.timer = Timer.scheduledTimer(timeInterval: self.drawPeriod,
                                          target: self,
                                          selector: #selector(waveAnimation),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    func stopAnimation() {
        self.timer.invalidate()
    }
    
    @objc private func waveAnimation() {
        self.setNeedsDisplay()
    }
    
    func path(from points: [CGPoint]) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        // 물결을 이루는 점들
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
    
    func movingOneStepPoints(points: [CGPoint]) -> [CGPoint] {
        
        return points.enumerated().map({ (idx, point) -> CGPoint in
            var yToMove =
                point == points.last ?
                points[0].y :
                points[idx + 1].y
            let xToMove =
                point == points.last ?
                self.width :
                point.x
                
            yToMove += 0.05
            return CGPoint(x: xToMove, y: yToMove)
        })
        
    }
    
}
