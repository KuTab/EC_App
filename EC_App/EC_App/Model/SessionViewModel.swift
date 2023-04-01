import Foundation

class SessionViewModel: ObservableObject {
    static let shared = SessionViewModel()
    
    @Published var name: String = ""
    @Published var number: String = ""
    @Published var description: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    
    public func createSession() {
        let formattedStartDate = startDate.replacingOccurrences(of: ".", with: "-") + "T22:35:39.471Z"
        let formattedEndDate = endDate.replacingOccurrences(of: ".", with: "-") + "T22:35:39.471Z"
        print(formattedEndDate)
        let session = Session(id: 0, number: self.number, startDate: formattedStartDate, endDate: formattedEndDate, description: self.description, name: self.name)
        APIManger.shared.addSessionRequest(session: session) { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }
}
