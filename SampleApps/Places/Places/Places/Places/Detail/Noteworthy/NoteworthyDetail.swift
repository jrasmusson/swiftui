import SwiftUI

struct NoteworthyDetail: View {
    let noteworthy: Noteworthy
    var body: some View {
        Text("Hello \(noteworthy.title)!")
            .navigationTitle(noteworthy.title)
    }
}

struct NoteworthyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoteworthyDetail(noteworthy: noteworthy1)
        }
        .preferredColorScheme(.dark)
    }
}
