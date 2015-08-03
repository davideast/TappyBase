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

class GameOverScene: CloudScene {
  
  var tapsLabel = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
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
      return summary.duration.metric.description
    }
  }
  
  init(size: CGSize, taps: Int, stage: Int, duration: NSTimeInterval) {
    super.init(size: size, backgroundMusic: "game-over.mp3", numLoops: 0)
    
    summary = GameSummary(taps: taps, stage: stage, duration: duration)
    
    tapsLabel.text = self.taps
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    backgroundColor = SKColor.whiteColor()
    
    addTapsLabel()
    addReplayLabel()
  }
  
  override func willMoveFromView(view: SKView) {
    super.willMoveFromView(view)
    backgroundMusicPlayer.stop()
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    let touch =  touches.first as! UITouch
    let touchLocation = touch.locationInNode(self)
    
    let node = nodeAtPoint(touchLocation)
    if node.name == "replay-button" {
  self.backgroundMusicPlayer.stop()
  let reveal = SKTransition.flipHorizontalWithDuration(0.5)
  let singlePlayScene = SinglePlayerScene(size: self.size)
  self.view?.presentScene(singlePlayScene, transition: reveal)
    }
  
  }
  
  func addReplayLabel() {
    replayButton.text = "Replay"
    replayButton.fontSize = 40
    replayButton.fontColor = TappyBaseColors.darkGrayColor()
    replayButton.name = "replay-button"
    replayButton.position = CGPoint(x: size.width / 2, y: (size.height / 2) - 100)
    replayButton.zPosition = CGFloat(1)
    replayButton.userInteractionEnabled = false
    addChild(replayButton)
  }
  
  func addTapsLabel() {
    tapsLabel.fontSize = 48
    tapsLabel.fontColor = SKColor.whiteColor()
    tapsLabel.name = "hits-label"
    tapsLabel.position = CGPoint(x: size.width / 2, y: (size.height / 2) + 100)
    tapsLabel.zPosition = CGFloat(1)
    tapsLabel.userInteractionEnabled = false
    addChild(tapsLabel)
  }
  
}