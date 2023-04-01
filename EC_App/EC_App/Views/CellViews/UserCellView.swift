import SwiftUI

struct UserCellView: View {
    @State var user: User
    
    var body: some View {
        ListView(viewModel: user.toListViewModel())
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView(user: User(firstName: "Test", lastName: "Test", username: "Test", email: "test@example.com", password: ""))
    }
}
