//
//  MatchLabel.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class MatchLabel: SKSpriteNode {
  
  var ownLabel: MainFontLabel
  var opponentLabel: MainFontLabel
  var versusLabel: MainFontLabel
  
  init(playerOne: String, playerTwo: String, parentFrame: CGRect) {
    
    let whiteColor = UIColor.whiteColor()
    
    ownLabel = MainFontLabel(text: playerOne, color: whiteColor)
    ownLabel.horizontalAlignmentMode = .Left
    ownLabel.fontSize = 18.0
    
    opponentLabel = MainFontLabel(text: playerTwo, color: whiteColor)
    ownLabel.horizontalAlignmentMode = .Right
    opponentLabel.fontSize = 18.0
    
    versusLabel = MainFontLabel(text: "vs.", color: whiteColor)
    versusLabel.horizontalAlignmentMode = .Center
    versusLabel.fontSize = 28.0
    
    ownLabel.position = CGPoint(x: parentFrame.width - (parentFrame.width - 40), y: CGRectGetMidY(parentFrame))
    opponentLabel.position = CGPoint(x: parentFrame.width - 40, y: CGRectGetMidY(parentFrame))
    versusLabel.position = CGPoint(x: CGRectGetMidX(parentFrame), y: CGRectGetMidY(parentFrame))
    
    let size = CGSize(width: parentFrame.width - 40, height: versusLabel.frame.height + 40)
    let ciBlack = CIColor(red: 255, green: 255, blue: 255, alpha: 0.2)
    let texture = SKTexture(size: size, topColor: ciBlack, bottomColor: ciBlack)
    super.init(texture: texture, color: UIColor.clearColor(), size: size)
    
    addChild(ownLabel)
    addChild(opponentLabel)
    addChild(versusLabel)
    
  }

  private func getCenterWithXOffset(frame: CGRect, xOffset: CGFloat) -> CGPoint {
    return CGPoint(x: xOffset, y: CGRectGetMidY(frame))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}