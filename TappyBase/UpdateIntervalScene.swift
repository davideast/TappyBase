//
//  UpdateIntervalScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

protocol UpdateIntervalProtocol {
  func totalGameTimeUpdate(totalGameTime: NSTimeInterval)
}

class UpdateIntervalScene: SKScene {
  
  var lastUpdateTimeInterval = NSTimeInterval(0)
  var totalGameTime = NSTimeInterval(0)
  var timeSinceEnemyAdded = NSTimeInterval(0)
  
  var onIntervalUpdate: ((totalGameTime: NSTimeInterval) -> Void)?
  
  override func update(currentTime: NSTimeInterval) {
    super.update(currentTime)
    
    if (lastUpdateTimeInterval > NSTimeInterval(0)) {
      timeSinceEnemyAdded += currentTime - lastUpdateTimeInterval
      totalGameTime += currentTime - lastUpdateTimeInterval
    }
    
    lastUpdateTimeInterval = currentTime
    
    onIntervalUpdate?(totalGameTime: totalGameTime)
    
  }
  
}