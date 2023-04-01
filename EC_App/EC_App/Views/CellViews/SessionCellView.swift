import SwiftUI

struct SessionCellView: View {
    @State var session: Session
    @State var isNearest: Bool
    
    var body: some View {
            ListView(viewModel: session.toListViewModel())
    }
}

struct SessionCellView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCellView(session: testSession, isNearest: false)
    }
}
