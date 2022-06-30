import SwiftUI

struct AddCompany: View {
    @StateObject var companies: Companies
    @State var name = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            TextField("New company name", text: $name)
                .toolbar {
                    Button(action: {
                        let company = Company(name: name, employees: [])
                        self.companies.items.append(company)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
        }
    }
}

struct AddCompany_Previews: PreviewProvider {
    static var previews: some View {
        AddCompany(companies: Companies())
    }
}
