//
//  GameOverScene.swift
//  TappyBase
//
//  Created by deast on 7/18/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

enum ButtonLabelDirection {
  case Left
  case Right
}

class GameOverScene: CloudScene {
  
  var summaryView: SKSpriteNode!
  var replayButton = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
  
  private var summary: GameSummary!
  
  var taps: String {
    get {
      return summary.taps.metric.description
    }
  }
  
  var stage: String {
    get {
      return summary.taps.metric.description
    }
  }
  
  var duration: String {
    get {
      return String(format: "%.2f", summary.duration.metric) + "s"
    }
  }
  
  init(size: CGSize, taps: Int, stage: Int, duration: NSTimeInterval) {
    super.init(size: size, backgroundMusic: "game-over.mp3", numLoops: 0)
    summary = GameSummary(taps: taps, stage: stage, duration: duration)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    backgroundColor = SKColor.whiteColor()
    
    
    summaryView = SKSpriteNode(color: TappyBaseColors.darkGrayColor(), size: CGSize(width: size.width, height: size.height))
    
    summaryView.alpha = 0.5
    summaryView.position = CGPoint(x: size.width / 2, y: size.height / 2)
    summaryView.zPosition = 1
    
    addChild(summaryView)
    
    let gameOverHeaderLabel = createHeaderLabel("Game Over", topOffset: 50)
    
    let blankLabel = createMetricLabel("", pairingHeader: gameOverHeaderLabel, order: 1)
    
    let tapsLabel = createMetricLabel("Taps", pairingHeader: gameOverHeaderLabel, order: 2)
    let tapsValueLabel = createMetricValueLabel(taps, pairingHeader: gameOverHeaderLabel, pairingLabel: tapsLabel)
    let tapsHighScoreLabel = createHighScoreLabel(tapsValueLabel)
    
    let durationLabel = createMetricLabel("Time", pairingHeader: gameOverHeaderLabel, order: 3)
    let durationValueLabel = createMetricValueLabel(duration, pairingHeader: gameOverHeaderLabel, pairingLabel: durationLabel)
    let durationHighScoreLabel = createHighScoreLabel(durationValueLabel)
    
    addChild(gameOverHeaderLabel)
    
    addChild(tapsLabel)
    addChild(tapsValueLabel)
    addChild(tapsHighScoreLabel)
    
    addChild(durationLabel)
    addChild(durationValueLabel)
    addChild(durationHighScoreLabel)
    
    let replay = createButtonLabel("Replay", name: "replay-button", pairingHeader: gameOverHeaderLabel, direction: .Left)
    let menu = createButtonLabel("Menu", name: "menu-button", pairingHeader: gameOverHeaderLabel, direction: .Right)
    
    addChild(replay)
    addChild(menu)
  }
  
  override func willMoveFromView(view: SKView) {
    super.willMoveFromView(view)
    backgroundMusicPlayer.stop()
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch =  touches.first {
      let touchLocation = touch.locationInNode(self)
      
      let node = nodeAtPoint(touchLocation)
      if node.name == "replay-button" {
        self.backgroundMusicPlayer.stop()
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let singlePlayScene = SinglePlayerScene(size: self.size)
        self.view?.presentScene(singlePlayScene, transition: reveal)
      }
      
      if node.name == "menu-button" {
        self.backgroundMusicPlayer.stop()
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let titleScene = TitleGameScene(size: self.size)
        self.view?.presentScene(titleScene, transition: reveal)
      }
    }
    
  }
  
  func createButtonLabel(text: String, name: String, pairingHeader: SKLabelNode, direction: ButtonLabelDirection) -> SKLabelNode {
    let buttonLabel = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
    
    buttonLabel.text = text
    buttonLabel.fontSize = 34
    buttonLabel.fontColor = SKColor.whiteColor()
    buttonLabel.name = name
    
    switch direction {
    case .Left:
      buttonLabel.position = CGPoint(x: pairingHeader.position.x - 150, y: (size.height / 2) - 150)
    case .Right:
      buttonLabel.position = CGPoint(x: pairingHeader.position.x + 150, y: (size.height / 2) - 150)
    }
    
    buttonLabel.zPosition = 2.0
    
    return buttonLabel
  }
  
  func createHeaderLabel(text: String, topOffset: CGFloat) -> SKLabelNode {
    let label = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
    label.fontSize = 48
    label.text = text
    label.fontColor = SKColor.whiteColor()
    label.position = CGPoint(x: size.width / 2, y: (size.height - label.frame.height) - topOffset)
    label.zPosition = 2.0
    label.userInteractionEnabled = false
    return label
  }
  
  func createMetricLabel(text: String, pairingHeader: SKLabelNode, order: Int) -> SKLabelNode {
    let orderHeight = CGFloat(order) * 50
    let label = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
    label.fontSize = 28
    label.text = text + ":"
    label.fontColor = TappyBaseColors.yellowColor()
    label.position = CGPoint(x: pairingHeader.position.x - 80, y: pairingHeader.position.y - orderHeight)
    label.zPosition = 2.0
    label.userInteractionEnabled = false
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
    return label
  }
  
  func createMetricValueLabel(text: String, pairingHeader: SKLabelNode, pairingLabel: SKLabelNode) -> SKLabelNode {
    let label = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
    label.fontSize = 28
    label.text = text
    label.fontColor = SKColor.whiteColor()
    label.position = CGPoint(x: pairingHeader.position.x + 150.0 - (label.frame.width), y: pairingLabel.position.y)
    label.zPosition = 2.0
    label.userInteractionEnabled = false
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
    return label
  }
  
  func createHighScoreLabel(pairingLabel: SKLabelNode) -> SKLabelNode {
    let label = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
    label.fontSize = 10
    label.text = "High Score!"
    label.fontColor = TappyBaseColors.yellowColor()
    label.position = CGPoint(x: (pairingLabel.position.x + pairingLabel.frame.width) + 10, y: pairingLabel.position.y)
    label.zPosition = 2.0
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
    let dimAction = SKAction.fadeAlphaTo(0.15, duration: 0.5)
    let brightenAction = SKAction.fadeAlphaTo(1.0, duration: 0.5)
    let glowingSequence = SKAction.sequence([dimAction, brightenAction])
    let glowForever = SKAction.repeatActionForever(glowingSequence)
    label.runAction(glowForever)
    return label
  }
  
}