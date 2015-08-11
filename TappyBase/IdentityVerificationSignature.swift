//
//  IdentityVerificationSignature.swift
//  TappyBase
//
//  Created by David East on 8/10/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

struct IdentityVerificationSignature {
  let publicKeyUrl: NSURL!
  let signature: NSData!
  let salt: NSData!
  let timestamp: UInt64
  let error: NSError!
  let playerID: String
  let bundleID: String
  
  init(publicKeyUrl: NSURL!, signature: NSData!, salt: NSData!, timestamp: UInt64, error: NSError!, playerID: String) {
    self.publicKeyUrl = publicKeyUrl
    self.signature = signature
    self.salt = salt
    self.timestamp = timestamp
    self.error = error
    self.playerID = playerID
    bundleID = NSBundle.mainBundle().bundleIdentifier!
  }
  
  func toJSON() -> [String: AnyObject] {
    let baseString = signature.base64EncodedStringWithOptions(nil)
    let saltString = salt.base64EncodedStringWithOptions(nil)
    
    let identityVerificationSignature = [
      "publicKeyUrl": publicKeyUrl.absoluteString!,
      "timestamp": String(format: "%llu", timestamp),
      "signature": baseString,
      "salt": saltString,
      "playerID": playerID,
      "bundleID": bundleID
    ]
    
    return identityVerificationSignature
  }
}

