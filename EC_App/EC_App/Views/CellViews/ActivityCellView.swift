import SwiftUI

struct ActivityCellView: View {
    @State var activity: Activity
    
    var body: some View {
        ListView(viewModel: activity.toListViewModel())
    }
}

struct ActivityCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCellView(activity: testActivity)
    }
}
