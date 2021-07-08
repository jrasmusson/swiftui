//
//  ContentView.swift
//  HelloCoreData
//
//  Created by jrasmusson on 2021-07-07.
//

import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManager
    
    @State private var movieTitle: String = ""
    @State private var movies = [Movie]()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title", text: $movieTitle)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    coreDM.saveMovie(title: movieTitle)
                    populateMovies()
                }
                List {
                    ForEach(movies, id: \.self) { movie in
                        Text(movie.title ?? "")
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            coreDM.deleteMovie(movie: movie)
                            populateMovies()
                        }
                    })
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Movies")
            
            .onAppear(perform: {
                populateMovies()
            })
        }
    }
    
    private func populateMovies() {
        movies = coreDM.getAllMovies()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
