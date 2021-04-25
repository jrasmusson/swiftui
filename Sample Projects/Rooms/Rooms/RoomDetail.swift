//
//  RoomDetail.swift
//  Rooms
//
//  Created by jrasmusson on 2021-04-24.
//

import SwiftUI

struct RoomDetail: View {
    let room: Room
    @State private var zoomed = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(room.imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill: .fit)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.25)) { zoomed.toggle() }
                }
                .navigationBarTitle(Text(room.name), displayMode: .inline)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            if room.hasVideo && !zoomed {
                Image(systemName: "video.fill")
                    .font(.title)
                    .padding(.all)
                    .transition(.move(edge: .leading))
            }
        }
    }
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView { RoomDetail(room: testData[1]) }
            NavigationView { RoomDetail(room: testData[3]) }
        }
    }
}
