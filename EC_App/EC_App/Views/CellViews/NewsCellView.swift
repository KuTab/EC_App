import SwiftUI

struct NewsCellView: View {
    @State
    var new: New
    
    var body: some View {
            ListView(viewModel: new.toListViewModel())
    }
}

struct NewsCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewsCellView(new: testNew)
    }
}
