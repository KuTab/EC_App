import SwiftUI

struct NearestSessionsView: View {
    @State var sessionList: [Session] = [testSession]
    @State var bottomSheetIsPresented: Bool = false
    @State var presentedSession: Session = testSession
    
    var body: some View {
        VStack {
            Text("Ближайшие сессии")
                .font(.system(size: 25))
                .bold()
            
            ScrollView {
                ForEach(sessionList, id: \.self) { session in
                    SessionCellView(session: session, isNearest: true)
                        .onTapGesture {
                            self.presentedSession = session
                            bottomSheetIsPresented.toggle()
                    }
                }
            }
        }.onAppear(perform: fetchSessions)
            .sheet(isPresented: $bottomSheetIsPresented) {
                NearestSessionDetailView(session: $presentedSession, isShowed: $bottomSheetIsPresented)
                    .presentationDetents([.height(400)])
                    .padding(.top)
            }
    }
    
    private func fetchSessions() {
        APIManger.shared.upcomingSessionsRequest { result in
            switch result {
            case .success(let sessions):
                sessionList = sessions
                print("success: \(sessions)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct NearestSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        NearestSessionsView()
    }
}
