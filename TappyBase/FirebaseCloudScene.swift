//
//  FirebaseCloudScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class FirebaseCloudScene: CloudScene {
  
  var waitForDuation = 0.5
  
  init(size: CGSize, backgroundMusic: String, waitForDuation: NSTimeInterval = 0.5) {
    super.init(size: size, backgroundMusic: backgroundMusic)
    self.waitForDuation = waitForDuation
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.runBlock(addFirebaseNode),
        SKAction.waitForDuration(self.waitForDuation)
        ])
      ))
  }
  
  func addFirebaseNode() {
    
    // Create sprite
    let firebaseNode = FirebaseSprite()
    moveFromLeft(firebaseNode, size: size, durationMin: 1.0, durationMax: 1.7, onDone: {
      SKAction.removeFromParent()
    })
    addChild(firebaseNode)
    
  }
  
}
