//
//  MatchmakingScene.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit
import GameKit
import SwiftHTTP

class MatchmakingScene : CloudScene {
  
  var findingLabel: FindingLabel!
  var opponentLabel: MainFontLabel!
  var ownLabel: MainFontLabel!
  var versusLabel: MainFontLabel!
  var opponent: Opponent!
  
  init(size: CGSize) {
    super.init(size: size, backgroundMusic: "")
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    let player = GKLocalPlayer.localPlayer()
    
    let whiteColor = UIColor.whiteColor()
    
    findingLabel = FindingLabel()
    findingLabel.position = getCenterWithXOffset(0)
    addChild(findingLabel)
    
    let matchManager = MatchManager(localPlayer: GKLocalPlayer.localPlayer())
    
    matchManager.findOrCreateMatch { (match: Match) in
      self.opponent = match.opponent
      self.opponentLabel.text = self.opponent.alias
      self.runAction(SKAction.runBlock({
        self.matchFound(match)
      }))
    }
    
    ownLabel = MainFontLabel(text: GKLocalPlayer.localPlayer().alias, color: whiteColor)
    ownLabel.alpha = 0.0
    ownLabel.fontSize = 18.0
    ownLabel.position = CGPoint(x: 40, y: CGRectGetMidY(frame))
    ownLabel.horizontalAlignmentMode = .Left
    addChild(ownLabel)
    
    opponentLabel = MainFontLabel(text: "", color: whiteColor)
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
  }
  
  func matchFound(match: Match) {
    
    let fadeInMatch = SKAction.sequence([
      SKAction.runBlock({
        self.findingLabel.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.3), SKAction.removeFromParent()]))
      }),
      SKAction.waitForDuration(1.0),
      SKAction.runBlock({
        let fadeInAction = SKAction.fadeInWithDuration(1.0)
        self.ownLabel.runAction(fadeInAction)
        self.opponentLabel.runAction(fadeInAction)
        self.versusLabel.runAction(fadeInAction)
      }),
      SKAction.waitForDuration(7.0),
      SKAction.runBlock({
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let multiplayerScreen = MultiplayerScene(size: self.size, match: match)
        self.view?.presentScene(multiplayerScreen, transition: reveal)
      })
      ])
    
    self.runAction(fadeInMatch)
    
  }
  
  func getCenterWithXOffset(xOffset: CGFloat) -> CGPoint {
    return CGPoint(x: (size.width / 2) - xOffset, y: size.height / 2)
  }
  
}
