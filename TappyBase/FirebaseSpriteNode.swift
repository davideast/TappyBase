//
//  FirebaseSpriteNode.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

struct FirebaseSpriteNode {
  let yAxis: CGFloat
  let position: CGPoint
  let duration: CGFloat
  var snapshot: FDataSnapshot?
  var firebaseNode: FirebaseNode?
  var skNode: SKSpriteNode!
  
  init(yAxis: CGFloat, position: CGPoint, duration: CGFloat) {
    self.yAxis = yAxis
    self.position = position
    self.duration = duration
    snapshot = nil
  }
  
  init(snapshot: FDataSnapshot) {
    let positionObj: AnyObject = snapshot.value.objectForKey("position")!
    let positionX = positionObj.objectForKey("x") as! CGFloat
    let positionY = positionObj.objectForKey("y") as! CGFloat
    
    position = CGPoint(x: positionX, y: positionY)
    yAxis = snapshot.value.objectForKey("yAxis") as! CGFloat
    duration = snapshot.value.objectForKey("duration") as! CGFloat
    self.snapshot = snapshot
  }
  
  func toAnyObject() -> AnyObject {
    return [
      "position": [
        "x": position.x,
        "y": position.y
      ],
      "yAxis": yAxis,
      "duration": duration
    ]
  }
  
  func removeFromParent() {
    firebaseNode?.removeFromParent()
  }
  
}