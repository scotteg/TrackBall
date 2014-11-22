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
  var redColor = UIColor.redColor()
  var orangeColor = UIColor.orangeColor()
  var yellowColor = UIColor.yellowColor()
  var greenColor = UIColor.greenColor()
  var blueColor = UIColor.blueColor()
  var purpleColor = UIColor.purpleColor()
  var trackBall: TrackBall?
  
  // MARK: - View life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSwipeMeTextLayer()
    buildCube()
  }
  
  // MARK: - Triggered actions
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    if let location = touches.anyObject()?.locationInView(viewForTransformLayer) {
      if trackBall != nil {
        trackBall?.setStartPointFromLocation(location)
      } else {
        trackBall = TrackBall(location: location, inRect: viewForTransformLayer.bounds)
      }
    }
  }
  
  override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    if let location = touches.anyObject()?.locationInView(viewForTransformLayer) {
      if let transform = trackBall?.rotationTransformForLocation(location) {
        viewForTransformLayer.layer.sublayerTransform = transform
      }
    }
  }
  
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    if let location = touches.anyObject()?.locationInView(viewForTransformLayer) {
      trackBall?.finalizeTrackBallForLocation(location)
    }
  }
  
  // MARK: - Helpers
  
  func setUpSwipeMeTextLayer() {
    swipeMeTextLayer.frame = CGRect(x: 0.0, y: sideLength / 4.0, width: sideLength, height: sideLength / 2.0)
    swipeMeTextLayer.string = "Swipe Me"
    swipeMeTextLayer.alignmentMode = kCAAlignmentCenter
    swipeMeTextLayer.foregroundColor = UIColor.whiteColor().CGColor
    let fontName = "Noteworthy-Light" as CFString
    let fontRef = CTFontCreateWithName(fontName, 24.0, nil)
    swipeMeTextLayer.font = fontRef
    swipeMeTextLayer.contentsScale = UIScreen.mainScreen().scale
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
  
  func sideLayerWithColor(color: UIColor) -> CALayer {
    let layer = CALayer()
    layer.frame = CGRect(origin: CGPointZero, size: CGSize(width: sideLength, height: sideLength))
    layer.position = CGPoint(x: CGRectGetMidX(viewForTransformLayer.bounds), y: CGRectGetMidY(viewForTransformLayer.bounds))
    layer.backgroundColor = color.CGColor
    return layer
  }
  
  func degreesToRadians(degrees: Double) -> CGFloat {
    return CGFloat(degrees * M_PI / 180.0)
  }
  
  func radiansToDegrees(radians: Double) -> CGFloat {
    return CGFloat(radians / M_PI * 180.0)
  }
  
}

