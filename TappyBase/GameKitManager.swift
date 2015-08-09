//
//  FireCenter.swift
//  TappyBase
//
//  Created by David East on 8/8/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import GameKit

typealias AuthResultCallback = (authResult: GameKitAuthResult) -> Void
typealias IdentityVerificationSignatureCallback = (identityVerificationSignature: [String: String!]) -> Void

class GameKitManager {

  
  /**
    Authenticates a local player with Game Center. Provides a callback
    for returning the result of the authentication.
  
    :param: A callback containing the result of the authentication
  */
  static func authenticatePlayer(callback: AuthResultCallback) {
    var localPlayer = GKLocalPlayer.localPlayer()
    localPlayer.authenticateHandler = { (vc, error) in
      let authResult = GameKitAuthResult(viewController: vc, player: localPlayer, error: error)
      callback(authResult: authResult)
    }
  }
  
  static func generateIdentityVerificationSignature(localPlayer: GKLocalPlayer, callback: IdentityVerificationSignatureCallback) {
    if localPlayer.authenticated {
      localPlayer.generateIdentityVerificationSignatureWithCompletionHandler({ (publicKeyUrl, signature, salt, timestamp, error) in
        
        let baseString = signature.base64EncodedStringWithOptions(nil)
        let saltString = salt.base64EncodedStringWithOptions(nil)
        
        let identityVerificationSignature = [
          "publicKeyUrl": publicKeyUrl.absoluteString,
          "timestamp": String(format: "%llu", timestamp),
          "signature": baseString,
          "salt": saltString,
          "playerID": localPlayer.playerID,
          "bundleID": NSBundle.mainBundle().bundleIdentifier
        ]
        
        callback(identityVerificationSignature: identityVerificationSignature)
      })
    }

  }
  
}