//
//  TappyBaseStages.swift
//  TappyBase
//
//  Created by deast on 7/31/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

struct TappyBaseStages {
  
  static func all() -> [Int: Stage] {
    return [
      1: TappyBaseStages.stageOne(),
      2: TappyBaseStages.stageTwo(),
      3: TappyBaseStages.stageThree(),
      4: TappyBaseStages.stageFour(),
      5: TappyBaseStages.stageFive()
    ]
  }
  
  static func stageOne() -> Stage {
    
    let number = 1
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1.0)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 1.5)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 1.0)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 0.8)
    let fourth = TimeSequence(start: 40, end: 43, spawnRate: -1.0)
    
    let sequences = [first, pre, second, third, fourth]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
  static func stageTwo() -> Stage {
    
    let number = 1
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1.0)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 1.5, spawnAmount: 2)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 1.0, spawnAmount: 2)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 0.85, spawnAmount: 2)
    let fourth = TimeSequence(start: 40, end: 43, spawnRate: -1.0)
    
    let sequences = [first, pre, second, third, fourth]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
  static func stageThree() -> Stage {
    
    let number = 2
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1.0)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 1.0, spawnAmount: 1)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 0.85, spawnAmount: 1)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 0.8, spawnAmount: 2)
    let fourth = TimeSequence(start: 40, end: 43, spawnRate: -1.0)
    
    let sequences = [first, pre, second, third, fourth]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
  static func stageFour() -> Stage {
    
    let number = 1
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1.0)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 1.5, spawnAmount: 2)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 1.25, spawnAmount: 2)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 1.0, spawnAmount: 2)
    let fourth = TimeSequence(start: 40, end: 60, spawnRate: 0.85, spawnAmount: 2)
    let fifth = TimeSequence(start: 60, end: 63, spawnRate: -1.0)
    
    let sequences = [first, pre, second, third, fourth, fifth]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
  static func stageFive() -> Stage {
    
    let number = 3
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 1.0, spawnAmount: 1)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 0.95, spawnAmount: 1)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 0.9, spawnAmount: 1)
    let fourth = TimeSequence(start: 40, end: 50, spawnRate: 0.85, spawnAmount: 1)
    let fifth = TimeSequence(start: 50, end: 60, spawnRate: 0.75, spawnAmount: 3)
    let sixth = TimeSequence(start: 60, end: 63, spawnRate: -1.0)
    
    let sequences = [first, pre, second, third, fourth, fifth, sixth]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
}