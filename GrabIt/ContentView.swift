//
//  ContentView.swift
//  GrabIt
//
//  Created by Suvidha Nakhawa on 2/4/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var gamescene = GameScene()
    
    
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                HStack(spacing: 5){
                    ForEach(0..<10){
                        Text("Item \($0)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(.gray)
                    }
                }
            }
            HStack{
                SpriteView(scene: gamescene)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                    .ignoresSafeArea()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
