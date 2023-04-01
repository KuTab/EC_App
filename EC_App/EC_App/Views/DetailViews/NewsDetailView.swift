import SwiftUI

struct NewsDetailView: View {
    var new: New
    var body: some View {
        Text(new.content)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(new: testNew)
    }
}
