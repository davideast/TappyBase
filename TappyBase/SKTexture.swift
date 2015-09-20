//
//  SKTexture.swift
//  TappyBase
//
//  Created by deast on 7/26/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

//inspired by https://gist.github.com/Tantas/7fc01803d6b559da48d6
extension SKTexture {
  
  convenience init(size:CGSize, topColor: CIColor, bottomColor: CIColor) {
    let context = CIContext(options: nil)
    let gradientFilter = CIFilter(name: "CILinearGradient")!
    gradientFilter.setDefaults()
    
    let startVector = CIVector(x: size.width/2, y: 0)
    let endVector = CIVector(x: size.width/2, y: size.height)
    
    gradientFilter.setValue(startVector, forKey: "inputPoint0")
    gradientFilter.setValue(endVector, forKey: "inputPoint1")
    
    gradientFilter.setValue(bottomColor, forKey: "inputColor0")
    gradientFilter.setValue(topColor, forKey: "inputColor1")
    
    let cgImg = context.createCGImage(gradientFilter.outputImage!, fromRect: CGRectMake(0, 0, size.width, size.height))
    
    // let image = UIImage(CGImage: cgImg)
    self.init(CGImage:cgImg)
  }
  
}