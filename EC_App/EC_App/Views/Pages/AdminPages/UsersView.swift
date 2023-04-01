import SwiftUI

struct UsersView: View {
    @State var usersList: [User] = []
    @State var bottomSheetIsPresented: Bool = false
    @State var presentedUser: User = User(firstName: "", lastName: "", username: "", email: "", password: "")
    @State var refetch: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Text("Пользователи")
                    .font(.system(size: 25))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }.padding(.horizontal, 20)
            
            ScrollView {
                ForEach(usersList, id: \.self) { user in
                    UserCellView(user: user).onTapGesture {
                        presentedUser = user
                        bottomSheetIsPresented.toggle()
                    }
                }
            }
        }.onAppear(perform: fetchUsers)
            .sheet(isPresented: $bottomSheetIsPresented) {
                UserView(user: $presentedUser, refetch: $refetch, mediaLink: presentedUser.mediaLink ?? "")
                    .presentationDetents([.height(500)])
            }.onChange(of: refetch) { newValue in
                if newValue {
                    fetchUsers()
                    refetch = false
                }
            }
    }
    
    private func fetchUsers() {
        APIManger.shared.usersAllRequest { result in
            switch result {
            case .success(let users):
                usersList = users
                print("success users all")
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
