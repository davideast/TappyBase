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
  var bgNode: SKSpriteNode!
  var clouds = [CloudSprite]()
  var cloudSpeed: CGFloat = 60.0
  
  private var lastCloudUpdate: NSTimeInterval = 0.0
  private var deltaTime : CGFloat = 0.01666
  
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
    bgNode = SKSpriteNode(texture: bgTexture)
    
    bgNode.position = CGPointMake(size.width / 2, size.height / 2)
    bgNode.zPosition = -1
    addChild(bgNode)
    
    // Clouds
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
    
  }
  
  override func update(currentTime: CFTimeInterval) {
    super.update(currentTime)
    
    deltaTime = CGFloat( currentTime - lastCloudUpdate)
    lastCloudUpdate = currentTime
    
    if deltaTime > 1.0 {
      deltaTime = 0.0166
    }
    
    moveCloudLayer(deltaTime)
  }
  
  func moveCloudLayer(deltaTime: CGFloat) {
    
    let xDirection: CGFloat = -1.0
    let yDirection: CGFloat = -1.0
    let time: CGFloat = CGFloat(deltaTime)
    
    for index in 0...clouds.count - 1 {
      let sprite = clouds[index]
      let newX = sprite.position.x + xDirection * cloudSpeed * deltaTime
      
      sprite.position = boundCheck(CGPoint(x: newX, y: sprite.position.y))
    }
    
  }
  
  private func boundCheck(pos: CGPoint) -> CGPoint {
    
    // scene bounderies
    let lowerXBound : CGFloat = -300
    var higherXBound : CGFloat = self.frame.width + 300
    
    var x = pos.x
    var y = pos.y
    
    if x < lowerXBound {
      x += higherXBound
    }
    
    if x > higherXBound {
      x -= higherXBound
    }
    
    return CGPointMake(x, y)
  }
  
  
  
}