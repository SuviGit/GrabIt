//
//  ItemView.swift
//  GrabIt
//
//  Created by Suvidha Nakhawa on 2/8/22.
//

import SwiftUI

struct ItemView: View {
    
    var item: Item
    @State var offset:CGSize = .zero
    
    var body: some View {
        HStack{

            Image(item.image)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .offset(offset)
                
        }
        
        .gesture(
        DragGesture()
            .onChanged({ value in
                offset = value.translation
            })
            .onEnded({ value in
                offset = .zero
            })
        )
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView()
//    }
//}
