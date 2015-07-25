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

func makeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> SKColor {
  return SKColor(red: CGFloat(red/255.0),
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
  
  static func nightSkyBlueColor() -> SKColor {
    return makeColor(2, 29, 44, 1.0)
  }
  
}

struct TappyBaseImages {
  
  static func firebaseSprite() -> String {
    return "8bit-base"
  }
  
  static func titleImage() -> String {
    return "tappy-base"
  }
  
  static func cloudImage() -> String {
    return "cloud"
  }
}

struct TappyBaseSounds {
  
  static func titleMusic() -> String {
    return "title-music"
  }
  
  static func firebaseTappedSx() -> String {
    return "base-tap.wav"
  }
  
  static func firebaseMissedSx() -> String {
    return "missed-base.wav"
  }
  
  
}
