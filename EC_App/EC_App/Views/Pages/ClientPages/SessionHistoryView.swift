import SwiftUI

struct SessionHistoryView: View {
    @State var sessionList: [Session] = []
    @State var bottomSheetIsPresented: Bool = false
    @State var presentedSession: Session = testSession
    
    var body: some View {
        VStack {
            Text("Мои сессии")
                .font(.system(size: 25))
                .bold()
            
            ScrollView {
                ForEach(sessionList, id: \.self) { session in
                    SessionCellView(session: session, isNearest: false).onTapGesture {
                        bottomSheetIsPresented.toggle()
                        presentedSession = session
                    }
                }
            }
        }.onAppear(perform: fetchSessions)
            .sheet(isPresented: $bottomSheetIsPresented) {
                SessionDetailView(session: $presentedSession)
                    .padding(.top)
                    .presentationDetents([.height(400)])
            }
    }
    
    private func fetchSessions() {
        APIManger.shared.sessionHystoryRequest(completion: { result in
            switch result {
            case .success(let sessions):
                sessionList = sessions
                print("success: \(sessions)")
            case .failure(let error):
                print(error)
            }
        })
    }
}

struct SessionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SessionHistoryView()
    }
}
