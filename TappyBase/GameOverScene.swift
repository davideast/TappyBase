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

class GameOverScene: SKScene {
  
  var backgroundMusicPlayer: AVAudioPlayer!
  var hitsLabel = SKLabelNode(fontNamed: "PressStart2P")
  var replayButton = SKLabelNode(fontNamed: "PressStart2P")
  
  init(size: CGSize, hits: Int) {
    super.init(size: size)
    hitsLabel.text = hits.description
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    backgroundColor = SKColor.whiteColor()
    
    backgroundMusicPlayer = playBackgroundMusic("game-over.mp3", numLoops: 0)
    
    addHitsLabel()
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
      backgroundMusicPlayer.stop()
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let mainGameScene = MainGameScene(size: self.size)
      self.view?.presentScene(mainGameScene, transition: reveal)
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
  
  func addHitsLabel() {
    hitsLabel.fontSize = 48
    hitsLabel.fontColor = TappyBaseColors.darkGrayColor()
    hitsLabel.name = "hits-label"
    hitsLabel.position = CGPoint(x: size.width / 2, y: (size.height / 2) + 100)
    hitsLabel.zPosition = CGFloat(1)
    hitsLabel.userInteractionEnabled = false
    addChild(hitsLabel)
  }
  
}