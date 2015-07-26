//
//  GameScene.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit
import AVFoundation

class TitleGameScene: SKScene {
  
  var backgroundMusicPlayer: AVAudioPlayer!
  var playButton = SKLabelNode(fontNamed: "PressStart2P")
  var titleLabel: SKSpriteNode!
  
  var clouds = [CloudSprite]()
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // GradientNode
    let topColor = TappyBaseColors.skyBlueCIColor()
    let bottomColor = TappyBaseColors.lightBlueCIColor()
    let bgTexture = SKTexture(size: size, topColor: topColor, bottomColor: bottomColor)
    let bgNode = SKSpriteNode(texture: bgTexture)
    bgNode.position = CGPointMake(size.width / 2, size.height / 2)
    bgNode.zPosition = -1
    
    addChild(bgNode)
    
    // TESTING CLOUDS
    for index in 0...10 {
      var indexAsDouble = Double(index)
      var xPos = 20.0 * (indexAsDouble * 5.0)
      var yPos = -10.0
      var position = CGPoint(x: xPos, y: yPos)
      let cloud = CloudSprite()
      cloud.position = position
      cloud.anchorPoint = CGPoint(x: 0, y: 0)
      addChild(cloud)
      clouds.append(cloud)
    }
    
    backgroundMusicPlayer = playBackgroundMusic("title-music.mp3")
    
    runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.runBlock(addFirebaseNode),
        SKAction.waitForDuration(0.5)
        ])
      ))
    
    addPlayButton()
    addTitleLabel()
    
  }
  
  override func willMoveFromView(view: SKView) {
    super.willMoveFromView(view)
    backgroundMusicPlayer.stop()
  }
  
  func addFirebaseNode() {
    
    // Create sprite
    let firebaseNode = SKSpriteNode(imageNamed: TappyBaseImages.firebaseSprite())

    // Determine where to spawn the monster along the Y axis
    let actualY = random(min: firebaseNode.size.height/2, size.height - firebaseNode.size.height/2)
    
    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    firebaseNode.position = CGPoint(x: size.width + firebaseNode.size.width/2, y: actualY)
    
    // Add the monster to the scene
    addChild(firebaseNode)
    
    // Determine speed of the monster
    let actualDuration = random(min: CGFloat(1.0), CGFloat(1.7))
    
    // Create the actions
    let actionMove = SKAction.moveTo(CGPoint(x: -firebaseNode.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
    let actionMoveDone = SKAction.removeFromParent()
    let loseAction = SKAction.runBlock() {

    }
    firebaseNode.runAction(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    let touch =  touches.first as! UITouch
    let touchLocation = touch.locationInNode(self)
    
    let node = nodeAtPoint(touchLocation)
    if node.name == "play-button" {
      backgroundMusicPlayer.stop()
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let mainGameScene = MainGameScene(size: self.size)
      self.view?.presentScene(mainGameScene, transition: reveal)
    }
    
  }
  
  func addPlayButton() {
    playButton.text = "Play"
    playButton.fontSize = 40
    playButton.fontColor = TappyBaseColors.darkGrayColor()
    playButton.name = "play-button"
    playButton.position = CGPoint(x: size.width / 2, y: (size.height / 2) - 100)
    playButton.zPosition = CGFloat(1)
    playButton.userInteractionEnabled = false
    addChild(playButton)
  }
  
  
  func addTitleLabel() {
    titleLabel = SKSpriteNode(imageNamed: "tappy-base")
    titleLabel.name = "tappy-base"
    titleLabel.position = CGPoint(x: size.width / 2, y: (size.height / 2) + 100)
    titleLabel.zPosition = CGFloat(1)
    addChild(titleLabel)
  }
  
  override func update(currentTime: NSTimeInterval) {

  }
  
}
