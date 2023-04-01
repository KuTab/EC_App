import Foundation

class RegisterManger: ObservableObject {
    static let shared = RegisterManger()
    
    @Published var firstName: String = ""
    
    @Published var lastName: String = ""
    
    @Published var username: String = ""
    
    @Published var email: String = ""
    
    @Published var password: String = ""
    
    @Published var isAdmin: Bool = false
    
    @Published var registered: Bool = false
    
    @Published var loggedIn: Bool = false
    
    @Published var token: Token?
    
    func register() {
        let user = User(firstName: self.firstName, lastName: self.lastName, username: self.username, email: self.email, password: self.password)
        APIManger.shared.registerRequest(user: user) { result in
            switch result {
            case .success(let token):
                self.token = token
                self.registered = true
                self.loggedIn = true
                self.isAdmin = token.userInfo!.isAdmin!
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func login() {
        APIManger.shared.authenticateRequest(username: self.email, password: self.password) { result in
            switch result {
            case .success(let token):
                self.token = token
                self.loggedIn = true
                self.isAdmin = token.userInfo!.isAdmin!
            case .failure(let error):
                print(error)
            }
        }
    }
}
