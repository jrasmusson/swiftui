//
//  ContentView.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var messenger = MessengerManager()
    
    var body: some View {
        VStack {
            
            Text("Send a New Year Message to you friends!")
                .font(.title)
                .padding()
            HStack {
                TextField("message", text: $messenger.message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    messenger.clear()
                       
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }.padding()
            
            EmojiCollectionView(messenger: messenger)
            

        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
