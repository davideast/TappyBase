//
//  TappableNode.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

protocol TappableNode {
  func tappedAction(scene: SKScene)
}