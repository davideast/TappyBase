//
//  FindingLabel.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class FindingLabel: FadingLabel {

  override init() {
    super.init()
    fontName = TappyBaseFonts.mainFont()
    fontColor = UIColor.whiteColor()
    fontSize = 20
    text = "Finding a friend..."
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}