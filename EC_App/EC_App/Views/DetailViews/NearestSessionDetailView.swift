import SwiftUI

struct NearestSessionDetailView: View {
    @Binding var session: Session
    @Binding var isShowed: Bool
    
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
            Button {
                bookSession()
                isShowed.toggle()
            } label: {
                Text("Забронировать")
            }.buttonStyle(.bordered)
                .padding()
        }
    }
    
    private func bookSession() {
        APIManger.shared.bookRequest(id: String(session.id)) { result in
            switch result {
            case .success(_):
                print("Booked success")
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct NearestSessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NearestSessionDetailView(session: .constant(testSession), isShowed: .constant(false))
    }
}
