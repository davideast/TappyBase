//
//  SinglePlayerHud.swift
//  TappyBase
//
//  Created by deast on 8/5/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

typealias HudCallback = ((hud: SinglePlayerHud) -> Void)

class SinglePlayerHud: SKSpriteNode {
  let smallSprite = BoltSprite()
  var livesLeftNode = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
  var pauseButton = PauseButton()
  var maskNode: SKSpriteNode!
  var onPauseTapped: HudCallback?
  
  init(size: CGSize, onPausedTapped: HudCallback?) {
    super.init(texture: nil, color: nil, size: size)
    self.onPauseTapped = onPausedTapped
    displayHUD()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func displayHUD() {
    
    smallSprite.anchorPoint = CGPoint(x: 0, y: 0)
    smallSprite.position = CGPoint(x: size.width - (smallSprite.size.width + livesLeftNode.frame.size.width + 70), y: size.height - (smallSprite.size.height + 20))
    
    livesLeftNode.position = CGPoint(x: size.width - (livesLeftNode.frame.size.width + 40), y: size.height - (smallSprite.size.height + 12))
    livesLeftNode.fontSize = 20
    
    pauseButton.anchorPoint = CGPoint(x: 0, y: 0)
    pauseButton.position = CGPoint(x: size.width - (pauseButton.size.width + 20), y: 10)
    pauseButton.zPosition = 3
    
    pauseButton.onTapped = {
      onPauseTapped?(hud: self)
    }
    
    maskNode = SKSpriteNode(color: UIColor.blackColor(), size: size)
    maskNode.position = CGPointMake(size.width / 2, size.height / 2)
    
    addChild(smallSprite)
    addChild(livesLeftNode)
    addChild(pauseButton)
  }
  
  func showPausedScreen() {
    maskNode.alpha = 0.3
    maskNode.zPosition = 2
    addChild(maskNode)
  }
  
  func unshowPausedScreen() {
    maskNode.removeFromParent()
  }
  
}