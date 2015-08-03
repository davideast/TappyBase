//
//  GameSummary.swift
//  TappyBase
//
//  Created by deast on 8/3/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

struct SummaryMetric<T> {
  let metric: T
  let isHighScore: Bool
  
  init(metric: T, isHighScore: Bool = false) {
    self.metric = metric
    self.isHighScore = isHighScore
  }
  
}

struct GameSummary {
  let taps: SummaryMetric<Int>
  let stage: SummaryMetric<Int>
  let duration: SummaryMetric<NSTimeInterval>
  let didWin: Bool
  
  init(taps: Int, stage: Int, duration: NSTimeInterval) {
    self.taps = SummaryMetric(metric: taps)
    self.stage = SummaryMetric(metric: stage)
    self.duration = SummaryMetric(metric: duration)
    self.didWin = false
  }
  
}
