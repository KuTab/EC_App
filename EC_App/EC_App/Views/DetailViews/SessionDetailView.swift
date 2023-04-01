import SwiftUI

struct SessionDetailView: View {
    @Binding var session: Session
    var body: some View {
        VStack {
            Text(session.number)
                .bold()
                .font(.system(size: 25))
                .padding()
            Text(session.name)
                .padding()
            Text(session.description)
                .padding()
        }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView(session: .constant(testSession))
    }
}
