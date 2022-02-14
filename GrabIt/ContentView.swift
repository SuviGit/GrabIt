//
//  ContentView.swift
//  GrabIt
//
//  Created by Suvidha Nakhawa on 2/4/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    //@State var items = Array<Item>(repeating: Item.example , count: 5)
    
    var sceneBounds = UIScreen.main.bounds
    
    var gamescene: SKScene{
    let gamescene = GameScene()
        gamescene.size = CGSize(width: sceneBounds.width, height: sceneBounds.height)
        
        return gamescene
    }
     var body: some View {
        VStack{
//            ScrollView(.horizontal){
//                HStack(spacing: 5){
//                    ForEach(0..<10){ index in
//
//                        //Text("Add items")
//                        HStack{
//
//                            ForEach(0..<items.count, id: \.self){index in
//
//                                ItemView(item: items[index])
//                            }
//                        }
//                    }
//                    .frame(width: 200, height: 200)
//                    .background(.gray)
//                }
//            }
            //ZStack{
                
                SpriteView(scene: gamescene)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)// - 200)
                    .ignoresSafeArea()

            //}
        }
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
