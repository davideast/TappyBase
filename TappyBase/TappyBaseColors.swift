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
    return makeColor(50, green: 47, blue: 49, alpha: 1.0)
  }
  
  static func yellowColor() -> SKColor  {
    return makeColor(251, green: 208, blue: 66, alpha: 1.0)
  }
  
  static func lightBlueColor() -> SKColor {
    return makeColor(162, green: 217, blue: 254, alpha: 1.0)
  }
  
  static func skyBlueColor() -> SKColor {
    return makeColor(41, green: 177, blue: 253, alpha: 1.0)
  }
  
  static func lightBlueCIColor() -> CIColor {
    return makeCIColor(162, green: 217, blue: 254, alpha: 1.0)
  }
  
  static func skyBlueCIColor() -> CIColor {
    return makeCIColor(41, green: 177, blue: 253, alpha: 1.0)
  }
  
  static func lightSkyBlueColor() -> SKColor {
    return makeColor(157, green: 220, blue: 251, alpha: 1.0)
  }
  
  static func nightSkyBlueColor() -> SKColor {
    return makeColor(2, green: 29, blue: 44, alpha: 1.0)
  }
  
  static func orangeSkyColor() -> SKColor {
    return makeColor(248, green: 182, blue: 76, alpha: 1.0)
  }
  
  static func redSkyColor() -> SKColor {
    return makeColor(227, green: 88, blue: 29, alpha: 1.0)
  }
}
