//
//  AddressView.swift
//  CupCake
//
//  Created by jrasmusson on 2021-05-07.
//

import Foundation
import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("Hello World")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
