//
//  GameViewController.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class GameViewController: UIViewController {
  
  var skView: SKView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("transitionToTitleScene"), name: "applicationDidBecomeActive", object: nil)

    let titleScene = TitleGameScene(size: view.bounds.size)
    skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    titleScene.scaleMode = .AspectFill
    skView.presentScene(titleScene)
  }
  
  func transitionToTitleScene(){
    if let theScene = self.skView.scene {
      if let singlePlayerScene = theScene as? SinglePlayerScene {
        singlePlayerScene.goHome()
      }
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    authenticate()
  }
  
  func authenticate() {
    GameKitManager.authenticatePlayer { authResult in
      
      if authResult.hasError {
        println(authResult.error?.userInfo?.description)
        return
      }
      
      if let vc = authResult.viewController {
        self.presentViewController(vc, animated: true, completion: nil)
      }
      
    }
  }
  
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
}
