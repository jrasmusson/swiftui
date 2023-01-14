//
//  ContentView.swift
//  CardFlip
//
//  Created by jrasmusson on 2022-05-12.
//



import SwiftUI

/// A struct that represents the front of a card
struct CardFront : View {
    /// The width of the card
    let width : CGFloat
    /// The height of the card
    let height : CGFloat
    /// The degree of rotation for the card
    @Binding var degree : Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Image(systemName: "suit.club.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)

        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

/// A struct that represents the back of a card
struct CardBack : View {
    /// The width of the card
    let width : CGFloat
    /// The height of the card
    let height : CGFloat
    /// The degree of rotation for the card
    @Binding var degree : Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .frame(width: width, height: height)

            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.2))
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.7))
                .padding()
                .frame(width: width, height: height)

            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .padding()
                .frame(width: width, height: height)

            Image(systemName: "seal.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue.opacity(0.7))

            Image(systemName: "seal")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)

            Image(systemName: "seal")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue.opacity(0.7))

        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))

    }
}

/// A struct that represents the main view of the card flip animation
struct ContentView: View {
    /// The degree of rotation for the back of the card
    @State var backDegree = 0.0
    /// The degree of rotation for the front of the card
    @State var frontDegree = -90.0
/// A boolean that keeps track of whether the card is flipped or not
@State var isFlipped = false
    /// The width of the card
let width : CGFloat = 200
/// The height of the card
let height : CGFloat = 250
/// The duration and delay of the flip animation
let durationAndDelay : CGFloat = 0.3

/// A function that flips the card by updating the degree of rotation for the front and back of the card
func flipCard () {
    isFlipped = !isFlipped
    if isFlipped {
        withAnimation(.linear(duration: durationAndDelay)) {
            backDegree = 90
        }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
            frontDegree = 0
        }
    } else {
        withAnimation(.linear(duration: durationAndDelay)) {
            frontDegree = -90
        }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
            backDegree = 0
        }
    }
}

var body: some View {
    ZStack {
        CardFront(width: width, height: height, degree: $frontDegree)
        CardBack(width: width, height: height, degree: $backDegree)
    }.onTapGesture {
        flipCard ()
    }
}
}

/// A struct that provides a preview of the ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




