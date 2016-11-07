//
//  ViewController.swift
//  TrackBallExample
//
//  Created by Scott Gardner on 11/22/14.
//  Copyright (c) 2014 Scott Gardner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewForTransformLayer: UIView!
    
    let sideLength = CGFloat(160.0)
    let reducedAlpha = CGFloat(0.8)
    
    var transformLayer: CATransformLayer!
    let swipeMeTextLayer = CATextLayer()
    var redColor = UIColor.red
    var orangeColor = UIColor.orange
    var yellowColor = UIColor.yellow
    var greenColor = UIColor.green
    var blueColor = UIColor.blue
    var purpleColor = UIColor.purple
    var trackBall: TrackBall?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSwipeMeTextLayer()
        buildCube()
    }
    
    // MARK: - Triggered actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: viewForTransformLayer) {
            if trackBall != nil {
                trackBall?.setStartPointFromLocation(location)
            } else {
                trackBall = TrackBall(location: location, inRect: viewForTransformLayer.bounds)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: viewForTransformLayer) {
            if let transform = trackBall?.rotationTransformForLocation(location) {
                viewForTransformLayer.layer.sublayerTransform = transform
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: viewForTransformLayer) {
            trackBall?.finalizeTrackBallForLocation(location)
        }
    }
    
    // MARK: - Helpers
    
    func setUpSwipeMeTextLayer() {
        swipeMeTextLayer.frame = CGRect(x: 0.0, y: sideLength / 4.0, width: sideLength, height: sideLength / 2.0)
        swipeMeTextLayer.string = "Swipe Me"
        swipeMeTextLayer.alignmentMode = kCAAlignmentCenter
        swipeMeTextLayer.foregroundColor = UIColor.white.cgColor
        let fontName = "Noteworthy-Light" as CFString
        let fontRef = CTFontCreateWithName(fontName, 24.0, nil)
        swipeMeTextLayer.font = fontRef
        swipeMeTextLayer.contentsScale = UIScreen.main.scale
    }
    
    func buildCube() {
        transformLayer = CATransformLayer()
        
        var layer = sideLayerWithColor(redColor)
        layer.addSublayer(swipeMeTextLayer)
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(orangeColor)
        var transform = CATransform3DMakeTranslation(sideLength / 2.0, 0.0, sideLength / -2.0)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 0.0, 1.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(yellowColor)
        layer.transform = CATransform3DMakeTranslation(0.0, 0.0, -sideLength)
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(greenColor)
        transform = CATransform3DMakeTranslation(sideLength / -2.0, 0.0, sideLength / -2.0)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 0.0, 1.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(blueColor)
        transform = CATransform3DMakeTranslation(0.0, sideLength / -2.0, sideLength / -2.0)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 1.0, 0.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(purpleColor)
        transform = CATransform3DMakeTranslation(0.0, sideLength / 2.0, sideLength / -2.0)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 1.0, 0.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        transformLayer.anchorPointZ = sideLength / -2.0
        viewForTransformLayer.layer.addSublayer(transformLayer)
    }
    
    func sideLayerWithColor(_ color: UIColor) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: sideLength, height: sideLength))
        layer.position = CGPoint(x: viewForTransformLayer.bounds.midX, y: viewForTransformLayer.bounds.midY)
        layer.backgroundColor = color.cgColor
        return layer
    }
    
    func degreesToRadians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * M_PI / 180.0)
    }
    
    func radiansToDegrees(_ radians: Double) -> CGFloat {
        return CGFloat(radians / M_PI * 180.0)
    }
    
}

