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
import GameKit

class TitleGameScene: FirebaseCloudScene {
  
  var onePlayerButton: PlayButton!
  var twoPlayerButton: PlayButton!
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
    addTwoPlayerButton()
    addTitleLabel()
  }
  
  // NODE: UI/PlayButton
  func addPlayButton() {
    onePlayerButton = PlayButton(text: "1p", name: "play-button", onTapped: {
      self.backgroundMusicPlayer.stop()
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let mainGameScene = SinglePlayerScene(size: self.size)
      self.view?.presentScene(mainGameScene, transition: reveal)
    })
    onePlayerButton.position = CGPoint(x: (size.width / 2) - 150, y: (size.height / 2) - 100)
    addChild(onePlayerButton)
  }
  
  func addTwoPlayerButton() {
    twoPlayerButton = PlayButton(text: "2p", name: "2play-button", onTapped: {
      self.backgroundMusicPlayer.stop()
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let matchmakingScene = MatchmakingScene(size: self.size)
      self.view?.presentScene(matchmakingScene, transition: reveal)
    })
    twoPlayerButton.position = CGPoint(x: (size.width / 2) + 150, y: (size.height / 2) - 100)
    addChild(twoPlayerButton)
  }
  
  // NODE: UI/TitleLabel
  func addTitleLabel() {
    titleLabel.position = CGPoint(x: size.width / 2, y: (size.height / 2) + 100)
    addChild(titleLabel)
  }
  
}
