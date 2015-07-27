//
//  TappableScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class TappableScene: SKScene {
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    
    let touch =  touches.first as! UITouch
    let touchLocation = touch.locationInNode(self)
    let node = nodeAtPoint(touchLocation)
    
    if let tappableNode = node as? TappableNode {
      tappableNode.tappedAction(self)
    }
    
  }
  
}