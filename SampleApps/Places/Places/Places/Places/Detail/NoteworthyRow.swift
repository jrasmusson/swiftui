import SwiftUI

struct NoteworthyRow: View {
    let noteworthy: Noteworthy
    let size: CGFloat = 48

    var body: some View {
        HStack {
            Image(systemName: noteworthy.iconName)
                .foregroundColor(appColor)
                .frame(width: size, height: size)
                .background(.ultraThinMaterial)
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(noteworthy.title)
                    .font(.headline)
                Text(noteworthy.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .cornerRadius(10)
    }
}

struct NoteworthyRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteworthyRow(noteworthy: noteworthy1)
            .preferredColorScheme(.dark)
    }
}
