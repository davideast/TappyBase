//
//  TitleGameScene
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//
//  Previous Scene: Root Scene from GameViewController
//  Next Scene: SinglePlayerScene on the PlayButton's tap
//

import SpriteKit
import AVFoundation

class TitleGameScene: FirebaseCloudScene {
  
  var playButton: PlayButton!
  var titleLabel = TitleLabel()
  
  init(size: CGSize) {
    super.init(size: size, backgroundMusic: TappyBaseSounds.titleMusic())
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    addPlayButton()
    addTitleLabel()
  }
  
  // NODE: UI/PlayButton
  func addPlayButton() {
    playButton = PlayButton(onTapped: {
      self.backgroundMusicPlayer.stop()
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let mainGameScene = SinglePlayerScene(size: self.size)
      self.view?.presentScene(mainGameScene, transition: reveal)
    })
    playButton.position = CGPoint(x: size.width / 2, y: (size.height / 2) - 100)
    addChild(playButton)
  }
  
  // NODE: UI/TitleLabel
  func addTitleLabel() {
    titleLabel.position = CGPoint(x: size.width / 2, y: (size.height / 2) + 100)
    addChild(titleLabel)
  }
  
}
