//
//  GameKitAuthResult.swift
//  TappyBase
//
//  Created by David East on 8/8/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import GameKit
import UIKit

struct GameKitAuthResult {
  let viewController: UIViewController?
  let player: GKLocalPlayer?
  let error: NSError?
  
  var authenticated: Bool {
    get {
      if let player = player {
        return player.authenticated
      }
      return false
    }
  }
  
  var hasError: Bool {
    get {
      if let error = error {
        return true
      }
      return false
    }
  }
  
  var hasViewController: Bool {
    get {
      if let vc = viewController {
        return true
      }
      return false
    }
  }
  
}