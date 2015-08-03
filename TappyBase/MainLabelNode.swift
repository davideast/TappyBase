//
//  MainFontNode.swift
//  TappyBase
//
//  Created by deast on 8/3/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class MainLabelNode: SKLabelNode {
  
  override init() {
    super.init(fontNamed: TappyBaseFonts.mainFont())
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}