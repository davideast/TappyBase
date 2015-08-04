//
//  TappyBaseColors.swift
//  TappyBase
//
//  Created by deast on 7/26/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

func makeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> SKColor {
  return SKColor(red: CGFloat(red/255.0),
    green: CGFloat(green/255.0),
    blue: CGFloat(blue/255.0),
    alpha: alpha)
}

func makeCIColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> CIColor {
  return CIColor(red: CGFloat(red/255.0),
    green: CGFloat(green/255.0),
    blue: CGFloat(blue/255.0),
    alpha: alpha)
}


struct TappyBaseColors {
  
  static func darkGrayColor() -> SKColor  {
    return makeColor(50, 47, 49, 1.0)
  }
  
  static func yellowColor() -> SKColor  {
    return makeColor(251, 208, 66, 1.0)
  }
  
  static func lightBlueColor() -> SKColor {
    return makeColor(162, 217, 254, 1.0)
  }
  
  static func skyBlueColor() -> SKColor {
    return makeColor(41, 177, 253, 1.0)
  }
  
  static func lightBlueCIColor() -> CIColor {
    return makeCIColor(162, 217, 254, 1.0)
  }
  
  static func skyBlueCIColor() -> CIColor {
    return makeCIColor(41, 177, 253, 1.0)
  }
  
  static func lightSkyBlueColor() -> SKColor {
    return makeColor(157, 220, 251, 1.0)
  }
  
  static func nightSkyBlueColor() -> SKColor {
    return makeColor(2, 29, 44, 1.0)
  }
  
  static func orangeSkyColor() -> SKColor {
    return makeColor(248, 182, 76, 1.0)
  }
  
  static func redSkyColor() -> SKColor {
    return makeColor(227, 88, 29, 1.0)
  }
}
