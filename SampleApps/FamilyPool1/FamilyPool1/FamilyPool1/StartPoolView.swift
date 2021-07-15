//
//  StartPoolView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-15.
//

import SwiftUI

struct StartPoolView: View {
//    var body: some View {
//        Button("Start Pool!", action: createPool)
//            .buttonStyle(.bordered)
//    }
//
//    func createPool() {
//        ResultsView()
//    }
    
    @State private var isPresented = false
    
    var body: some View {
        Button("Present!") {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented, content: ResultsView.init)
    }
}

struct StartPoolView_Previews: PreviewProvider {
    static var previews: some View {
        StartPoolView()
    }
}
