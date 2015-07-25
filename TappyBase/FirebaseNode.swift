//
//  FirebaseNode.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

struct FirebaseNode {
  let skNode: SKSpriteNode
  var snapshot: FDataSnapshot?
  
  func removeFromParent() {
    skNode.removeFromParent()
    snapshot?.ref.removeValue()
  }
}
