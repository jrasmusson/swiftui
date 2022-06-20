//
//  NoteworthyRow.swift
//  Places
//
//  Created by jrasmusson on 2022-06-19.
//

import SwiftUI

struct NoteworthyRow: View {
    let noteworthy: Noteworthy
    let size: CGFloat = 48

    var body: some View {
        HStack {
            Image(systemName: noteworthy.iconName)
                .tint(.green)
//                .resizable()
//                .scaledToFit()
//                .padding(10)


                .frame(width: size, height: size)
                .background(.secondary)
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(noteworthy.title)
                    .font(.headline)
                Text(noteworthy.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
}

struct NoteworthyRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteworthyRow(noteworthy: notworthy1)
            .preferredColorScheme(.dark)
    }
}
