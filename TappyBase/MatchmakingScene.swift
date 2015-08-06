//
//  MatchmakingScene.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class MatchmakingScene : CloudScene {
  
  var findingLabel: FindingLabel!
  var opponentLabel: MainFontLabel!
  var ownLabel: MainFontLabel!
  var versusLabel: MainFontLabel!
  
  init(size: CGSize) {
    super.init(size: size, backgroundMusic: "")
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    let whiteColor = UIColor.whiteColor()
    
    findingLabel = FindingLabel()
    findingLabel.position = getCenterWithXOffset(0)
    addChild(findingLabel)
    
    let waitAndFind = SKAction.sequence([
      SKAction.waitForDuration(5.0),
      SKAction.runBlock(matchFound)
      ])
    
    ownLabel = MainFontLabel(text: "david.east", color: whiteColor)
    ownLabel.alpha = 0.0
    ownLabel.fontSize = 18.0
    ownLabel.position = CGPoint(x: 40, y: CGRectGetMidY(frame)) //getCenterWithXOffset(200)
    ownLabel.horizontalAlignmentMode = .Left
    addChild(ownLabel)
    
    opponentLabel = MainFontLabel(text: "shannon.east", color: whiteColor)
    opponentLabel.alpha = 0.0
    opponentLabel.fontSize = 18.0
    opponentLabel.position = CGPoint(x: frame.width - 40, y: CGRectGetMidY(frame))
    opponentLabel.horizontalAlignmentMode = .Right
    addChild(opponentLabel)
    
    versusLabel = MainFontLabel(text: "vs.", color: whiteColor)
    versusLabel.alpha = 0.0
    versusLabel.fontSize = 28.0
    versusLabel.position = getCenterWithXOffset(0)
    addChild(versusLabel)

    runAction(waitAndFind)
  }
  
  func matchFound() {
    
    let fadeInMatch = SKAction.sequence([
      SKAction.runBlock({
        self.findingLabel.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(1.0), SKAction.removeFromParent()]))
      }),
      SKAction.waitForDuration(1.0),
      SKAction.runBlock({
        let fadeInAction = SKAction.fadeInWithDuration(1.0)
        self.ownLabel.runAction(fadeInAction)
        self.opponentLabel.runAction(fadeInAction)
        self.versusLabel.runAction(fadeInAction)
      })
      ])
    
    self.runAction(fadeInMatch)
    
  }
  
  func getCenterWithXOffset(xOffset: CGFloat) -> CGPoint {
    return CGPoint(x: (size.width / 2) - xOffset, y: size.height / 2)
  }
  
}
