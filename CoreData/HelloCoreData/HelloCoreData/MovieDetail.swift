//
//  MovieDetail.swift
//  HelloCoreData
//
//  Created by jrasmusson on 2021-07-08.
//

import SwiftUI

struct MovieDetail: View {
    
    let movie: Movie
    let coreDM: CoreDataManager
    
    @State private var movieName: String = ""
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(.roundedBorder)
            Button("Update") {
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDM.updateMovie()
                    needsRefresh.toggle()
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie()
        let coreDM = CoreDataManager()
        MovieDetail(movie: movie, coreDM: coreDM, needsRefresh: .constant(false))
    }
}
