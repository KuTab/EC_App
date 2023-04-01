import SwiftUI

struct SessionCreationView: View {
    @StateObject var viewModel: SessionViewModel = SessionViewModel.shared
    @State var sessionList: [Session] = []
    @State var bottomSheetIsPresented: Bool = false
    @State var creationSheetIsPresented: Bool = false
    @State var presentedSession: Session = testSession
    @State var refetch: Bool = false
    var body: some View {
        VStack {
            ZStack {
                Text("Сессии")
                    .font(.system(size: 25))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button {
                    creationSheetIsPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }.frame(maxWidth: .infinity, alignment: .trailing)

            }.padding(.horizontal, 20)
            
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
            }
            .sheet(isPresented: $creationSheetIsPresented) {
                AddSessionView(isPresented: $creationSheetIsPresented, refetch: $refetch)
                    .padding(.top)
            }.onChange(of: refetch) { newValue in
                if newValue {
                    fetchSessions()
                    refetch = false
                }
            }
    }
    
    private func fetchSessions() {
        APIManger.shared.upcomingSessionsRequest(completion: { result in
            switch result {
            case .success(let sessions):
                sessionList = sessions
                print("success: \(sessions)")
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func addSession() {
        
    }
}

struct SessionCreationView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCreationView()
    }
}
