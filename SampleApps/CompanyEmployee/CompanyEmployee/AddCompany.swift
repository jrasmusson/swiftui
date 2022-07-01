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
                        let company = Company(id: UUID().uuidString, name: name, employees: [])
                        // 1. Update the local model
                        self.companies.items.append(company)
                        // 2. Network call to save to backend
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
                .padding()
        }
    }
}

struct AddCompany_Previews: PreviewProvider {
    static var previews: some View {
        AddCompany(companies: Companies())
    }
}
