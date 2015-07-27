//
//  GameViewController.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  var skView: SKView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    println(view.bounds.size.height)
    println(view.bounds.size.width)
    let titleScene = TitleGameScene(size: view.bounds.size)
    skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    titleScene.scaleMode = .ResizeFill
    skView.presentScene(titleScene)
    
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  
}
