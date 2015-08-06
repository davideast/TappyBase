//
//  MainFontLabel.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class MainFontLabel: SKLabelNode {
  
  override init() {
    super.init()
    fontName = TappyBaseFonts.mainFont()
  }
  
  init(text: String!, color: UIColor) {
    super.init()
    self.text = text
    fontColor = color
    fontName = TappyBaseFonts.mainFont()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
