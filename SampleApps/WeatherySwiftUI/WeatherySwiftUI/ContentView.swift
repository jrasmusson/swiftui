//
//  ContentView.swift
//  WeatherySwiftUI
//
//  Created by jrasmusson on 2021-06-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                CalendarView()
                Spacer()
            }
            Text("Event title").font(.title)
            Spacer()
        }.padding()
    }
}


struct CalendarView: View {
    var body: some View {
        Image(systemName: "calendar")
            .resizable()
            .frame(width: 50, height: 50)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
