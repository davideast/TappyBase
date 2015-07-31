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
      3: TappyBaseStages.stageThree()
    ]
  }
  
  static func stageOne() -> Stage {
    
    let number = 1
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1.0)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 1.5)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 1.25)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 1.0)
    let fourth = TimeSequence(start: 40, end: 60, spawnRate: 0.9)
    let fifth = TimeSequence(start: 60, end: 80, spawnRate: 0.85)
    let sixth = TimeSequence(start: 80, end: 83, spawnRate: -1.0)
    
    let sequences = [first, pre, second, third, fourth, fifth, sixth]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
  static func stageTwo() -> Stage {
    
    let number = 2
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1.0)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 1.0)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 0.9)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 0.85)
    let fourth = TimeSequence(start: 40, end: 60, spawnRate: 0.8)
    let fifth = TimeSequence(start: 60, end: 80, spawnRate: 0.75)
    let sixth = TimeSequence(start: 80, end: 100, spawnRate: 0.7)
    let seventh = TimeSequence(start: 100, end: 103, spawnRate: -1.0)
    
    let sequences = [first, pre, second, third, fourth, fifth, sixth, seventh]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
  static func stageThree() -> Stage {
    
    let number = 3
    
    let first = TimeSequence(start: 0.0, end: 4.0, spawnRate: -1)
    let pre = TimeSequence(start: 4.0, end: 14.0, spawnRate: 0.9)
    let second = TimeSequence(start: 14.0, end: 20.0, spawnRate: 0.85)
    let third = TimeSequence(start: 20, end: 40, spawnRate: 0.8)
    let fourth = TimeSequence(start: 40, end: 60, spawnRate: 0.75)
    let fifth = TimeSequence(start: 60, end: 80, spawnRate: 0.7)
    let sixth = TimeSequence(start: 80, end: 90, spawnRate: 0.65)
    let seventh = TimeSequence(start: 90, end: 100, spawnRate: 0.6)
    let eigth = TimeSequence(start: 100, end: 103, spawnRate: -10.0)
    
    let sequences = [first, pre, second, third, fourth, fifth, sixth, seventh, eigth]
    
    return Stage(number: number, timeSequences: sequences)
  }
  
}