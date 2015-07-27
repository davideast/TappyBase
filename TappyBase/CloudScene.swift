//
//  CloudScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class CloudScene: TappableScene {
  
  var backgroundMusicPlayer: AVAudioPlayer!
  
  init(size: CGSize, backgroundMusic: String) {
    super.init(size: size)
    backgroundMusicPlayer = playBackgroundMusic(backgroundMusic)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // TODO: Refactor into GradientNode
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
    }
    
  }
  
  
  
}