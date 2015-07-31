//
//  StageCreator.swift
//  TappyBase
//
//  Created by deast on 7/31/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

class StageCreator {
  
  static func createStages(numberOfStages: Int) {
    
    for index in 1...numberOfStages {
      let stage = StageCreator.createStage(index, duration: 100.0, startingSpawnRate: 1.0, spawnRateIncrement: 0.1)
    }
    
  }
  
  private static func createStage(number: Int, duration: NSTimeInterval, var startingSpawnRate: NSTimeInterval, spawnRateIncrement: NSTimeInterval) -> Stage {
   
    let interval = 5
    let intervalTime = 20.0
    var sequences = [TimeSequence]()
    
    
    
    for index in 1...interval {
      
      let startingInterval = NSTimeInterval(index) * intervalTime
      let endingInterval = startingInterval + intervalTime
      startingSpawnRate = startingSpawnRate - spawnRateIncrement
      
      let sequence = TimeSequence(start: startingInterval, end: endingInterval, spawnRate: startingSpawnRate)
      sequences.append(sequence)
    }
    
    var stage = Stage(number: number, timeSequences: sequences)
    return stage
  }
  
}