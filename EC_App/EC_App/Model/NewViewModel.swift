import Foundation

class NewViewModel: ObservableObject {
    static let shared = NewViewModel()
    @Published var title: String = ""
    @Published var content: String = ""
    
    public func postNew() {
        let new = New(id: 0, title: self.title, content: self.content, createdAt: "")
        APIManger.shared.postNewRequest(new: new) { result in
            switch result {
            case .success(_):
                print("New added")
            case .failure(let error):
                print(error)
            }
        }
    }
}
