//
//  MatchManager.swift
//  TappyBase
//
//  Created by David East on 8/8/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import GameKit

struct Match {
  let localPlayer: LocalPlayer
  let opponent: Opponent
  let ref: Firebase
}

// The three states
//  1. Look for a match
//  2. Create a match if none
//  3. Wait for a player

class MatchManager {
  
  let lobbyRef: Firebase = TappyBaseConstants.lobbyRef()
  let localPlayer: GKLocalPlayer
  
  init(localPlayer: GKLocalPlayer) {
    self.localPlayer = localPlayer
  }
  
  func findOrCreateMatch(onOpponentJoin: (match: Match) -> Void) {
    searchMatches { match in
      
      // if there is a match
      if let foundMatch = match {
        
        onOpponentJoin(match: foundMatch)
        
      } else {
        
        self.createMatch({ foundMatch in
          
          onOpponentJoin(match: foundMatch)
          
        })
        
      }
      
    }
  }
  
  private func searchMatches(onMatchFound: (match: Match?) -> Void) {
    lobbyRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
      
      var matchFound: Match?
      
      for childSnap in snapshot.children {
        let snap: FDataSnapshot = childSnap as! FDataSnapshot
        
        // Someone is waiting
        if snap.childrenCount == 1 {
          let matchRef = snap.ref
          // join
          let localPlayerRef = matchRef.childByAppendingPath(self.localPlayer.playerID)
          localPlayerRef.setValue(self.localPlayer.alias)
          
          // get the opponent snap
          var opponentSnap: FDataSnapshot?
          for playerSnap in snap.children {
            opponentSnap = playerSnap as? FDataSnapshot
            break
          }
          
          // create match
          let local = LocalPlayer(localPlayer: self.localPlayer, ref: localPlayerRef)
          let opponent = Opponent(snapshot: opponentSnap!)
          let match = Match(localPlayer: local, opponent: opponent, ref: matchRef)
          
          matchFound = match
          break
        }
        
      }
      
      onMatchFound(match: matchFound)
    })
  }
  
  private func createMatch(onOpponentJoin: (match: Match) -> Void) {
    let matchRef = lobbyRef.childByAutoId()
    let localPlayerRef = matchRef.childByAppendingPath(localPlayer.playerID)
    localPlayerRef.setValue(localPlayer.alias)
    
    // Wait for a player to join
    matchRef.observeEventType(FEventType.ChildAdded, withBlock: { (snap: FDataSnapshot!) in
      
      // If the player joining is not the local player
      if snap.key != self.localPlayer.playerID {
        let local = LocalPlayer(localPlayer: self.localPlayer, ref: localPlayerRef)
        let opponent = Opponent(snapshot: snap)
        let match = Match(localPlayer: local, opponent: opponent, ref: matchRef)
        onOpponentJoin(match: match)
      }
    })
  }
  
}
