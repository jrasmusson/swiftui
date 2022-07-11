//
//  TestView.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-11.
//

import SwiftUI

//struct TestView: View {
//    @State private var showingAlert = false
//
//    var body: some View {
//        Button("Show Alert") {
//            showingAlert = true
//        }
//        .alert("Important message", isPresented: $showingAlert) {
//            Button("First") { }
//            Button("Second") { }
//            Button("Third") { }
//        }
//    }
//}

struct TestView: View {
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            Text("Hi")
        }
        .toolbar {
            Button(action: {
                showingAlert = true
            }) {
                Image(systemName: "plus")
            }
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("First") { }
            Button("Second") { }
            Button("Third") { }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TestView()
        }
    }
}
