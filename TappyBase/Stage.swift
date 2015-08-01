//
//  Stage.swift
//  TappyBase
//
//  Created by deast on 7/30/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

struct Stage {
  let number: Int
  let timeSequences: [TimeSequence]
  
  var totalTime: NSTimeInterval {
    get {
      return timeSequences.last!.end
    }
  }
  
  init(number: Int, timeSequences: [TimeSequence]) {
    self.number = number
    self.timeSequences = timeSequences
  }
  
  func sequenceContainingInterval(interval: NSTimeInterval) -> TimeSequence? {
    
    for sequence in timeSequences {
      
      if sequence.start <= interval && sequence.end >= interval {
        return sequence
      }
      
    }
    
    return nil
  }
}

struct TimeSequence {
  let start: NSTimeInterval
  let end: NSTimeInterval
  let spawnRate: NSTimeInterval
  let spawnAmount: Int
  
  init(start: NSTimeInterval, end: NSTimeInterval, spawnRate: NSTimeInterval, spawnAmount: Int = 1) {
    self.start = start
    self.end = end
    self.spawnRate = spawnRate
    self.spawnAmount = spawnAmount
  }
}