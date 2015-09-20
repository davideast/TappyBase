//
//  TappableScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class TappableScene: UpdateIntervalScene {
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    if let touch =  touches.first {
      let touchLocation = touch.locationInNode(self)
      let node = nodeAtPoint(touchLocation)
      
      if let tappableNode = node as? TappableNode {
        tappableNode.tappedAction(self)
      }
    }
    
  }
  
}