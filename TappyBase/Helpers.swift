//
//  Helpers.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

func playBackgroundMusic(filename: String, numLoops: Int = -1) -> AVAudioPlayer? {
  let url = NSBundle.mainBundle().URLForResource(
    filename, withExtension: nil)
  if (url == nil) {
    println("Could not find file: \(filename)")
    return nil
  }
  
  var error: NSError? = nil
  var backgroundMusicPlayer =
    AVAudioPlayer(contentsOfURL: url, error: &error)
  if backgroundMusicPlayer == nil {
    println("Could not create audio player: \(error!)")
    return nil
  }
  
  backgroundMusicPlayer.numberOfLoops = numLoops
  backgroundMusicPlayer.prepareToPlay()
  backgroundMusicPlayer.play()
  
  return backgroundMusicPlayer
}

func random() -> CGFloat {
  return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(#min: CGFloat, max: CGFloat) -> CGFloat {
  return random() * (max - min) + min
}

func textureWithVerticalGradientOfSize(size: CGSize, topColor: CIColor, bottomColor: CIColor) -> SKTexture {
  
  let context = CIContext(options: nil)
  let gradientFilter = CIFilter(name: "CILinearGradient")
  gradientFilter.setDefaults()
  
  let startVector = CIVector(x: size.width/2, y: 0)
  let endVector = CIVector(x: size.width/2, y: size.height)
  
  gradientFilter.setValue(startVector, forKey: "inputPoint0")
  gradientFilter.setValue(endVector, forKey: "inputPoint1")
  
  gradientFilter.setValue(bottomColor, forKey: "inputColor0")
  gradientFilter.setValue(topColor, forKey: "inputColor1")
  
  let cgImg = context.createCGImage(gradientFilter.outputImage, fromRect: CGRectMake(0, 0, size.width, size.height))
  
  let image = UIImage(CGImage: cgImg)!
  let texture = SKTexture(image: image)
  
  return texture
}