//
//  GradientNode.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class GradientNode : SKSpriteNode {
  
  init(textureSize: CGSize, zPosition: CGFloat = -1) {
    let topColor = TappyBaseColors.skyBlueCIColor()
    let bottomColor = TappyBaseColors.lightBlueCIColor()
    let bgTexture = SKTexture(size: textureSize, topColor: topColor, bottomColor: bottomColor)
    let bgNode = SKSpriteNode(texture: bgTexture)
    bgNode.position = CGPointMake(textureSize.width / 2, textureSize.height / 2)
    bgNode.zPosition = zPosition
    super.init(texture: bgTexture, color: UIColor.clearColor(), size: bgTexture.size())
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}