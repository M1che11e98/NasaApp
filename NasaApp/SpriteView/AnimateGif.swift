//
//  AnimateGif.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 28/03/23.
//

import SwiftUI
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    
    private var playerAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Earth")
    }
    
    private var playerTexture: SKTexture {
        return playerAtlas.textureNamed("Earth")
    }
    
    private var playerIdleTextures: [SKTexture] = []

    
    // {
//        return [
//
//            playerAtlas.textureNamed("1"),
//            playerAtlas.textureNamed("2"),
//            playerAtlas.textureNamed("3"),
//            playerAtlas.textureNamed("4"),
//            playerAtlas.textureNamed("5"),
//            playerAtlas.textureNamed("6"),
//            playerAtlas.textureNamed("7"),
//            playerAtlas.textureNamed("8"),
//            playerAtlas.textureNamed("9"),
//            playerAtlas.textureNamed("11"),
//        ]
   // }
    
    private func setupPlayer () {
        player = SKSpriteNode(texture: playerTexture, size: CGSize(width: 80, height: 80))
        player.position = CGPoint(x:frame.width/2, y: frame.height/2)
        addChild(player)
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(.white)
        self.setupPlayer()
        self.action()
        
    }
    
    func action() {
        
        for index in 0..<playerAtlas.textureNames.count {
            let textureNames = "frame_\(index)_delay-0.08s" //String(index + 1)
            playerIdleTextures.append(playerAtlas.textureNamed(textureNames))
            
        }
        
        
        let action = SKAction.animate(with: playerIdleTextures, timePerFrame: 0.250)
        
        let paintAction = SKAction.repeatForever(action)
        player.run(paintAction)
        
        player.run(SKAction.repeat(action, count: 1), withKey: ("playerIdleAnimation"))
    }
 
  }
    
  

struct AnimateGif: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        return scene
    }
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 100, height: 100)
            HStack {
                Text("Loading...")
//                FadeInOutView(text: ". . .", startTime: 1.0)
  
            }
          
        }
     
    }
    
}
                
//struct FadeInOutView: View {
//
//    @State var characters: Array<String.Element>
//    @State var opacity: Double = 0
//    @State var baseTime: Double
//
//    init(text: String, startTime: Double) {
//        characters = Array(text)
//        baseTime = startTime
//    }
//
//    var body: some View {
//        HStack(spacing:0){
//            ForEach(0..<characters.count) { num in
//                Text(String(self.characters[num]))
//                    .font(.title)
//                    .opacity(opacity)
//                    .animation(.easeInOut.delay( Double(num) * 0.05 ),
//                               value: opacity)
//            }
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime){
//                opacity = 1
//            }
//        }
//        .onTapGesture {
//            opacity = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//                opacity = 1
//            }
//        }
//    }
//}


struct AnimateGif_Previews: PreviewProvider {
    static var previews: some View {
        AnimateGif()
    }
}

