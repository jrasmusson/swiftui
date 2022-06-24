//
//  AccountHeader.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-24.
//

import SwiftUI

struct AccountHeader: View {
    let size: CGFloat = 100
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good morning Kevin")
                Text(Date.now.monthDayYearString)
            }
            Spacer()
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.yellow)
                .frame(width: size, height: size)
        }
    }
}

struct AccountHeader_Previews: PreviewProvider {
    static var previews: some View {
        AccountHeader()
    }
}
