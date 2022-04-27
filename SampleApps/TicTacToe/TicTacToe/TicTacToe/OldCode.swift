//
//  OldCode.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-27.
//

//import SwiftUI
//
//struct ContentView: View {
//    @ObservedObject var viewModel: ViewModel
//    @State var isXTurn = false
//
//    var button: some View {
//        Button(action: {}) {
//            Image(systemName: "x.square.fill")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .padding()
//        }
//    }
//
//    func textFor(position: Position) -> some View {
//        Text(viewModel.get(position).description)
//            .font(.largeTitle)
//            .frame(width: 50, height: 50)
//            .padding()
//    }
//
//    var body: some View {
//        VStack {
//            HStack {
//                Button(action: {
//                    print("action")
//                    viewModel.set(.upperLeft, isXTurn ? .x : .o)
//                    isXTurn.toggle()
//                }) {
//                    textFor(position: .upperLeft)
//                }
//
//                button
//                button
//            }
//            HStack {
//                button
//                button
//                button
//            }
//            HStack {
//                button
//                button
//                button
//            }
//            Toggle(isOn: $isXTurn) {
//                Text("Hello World")
//            }
//            if isXTurn {
//                Text("X Turn")
//            } else {
//                Text("Y Turn")
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: ViewModel())
//    }
//}
