import SwiftUI

struct NewsView: View {
    @State var newsList: [New] = testNewList
    
    var body: some View {
        VStack {
            Text("Новости")
                .font(.system(size: 25))
                .bold()
            
            ScrollView {
                ForEach(newsList, id: \.self) { new in
                    NewsCellView(new: new)
                }
            }
        }.onAppear(perform: fetchNews)
    }
    
    private func fetchNews() {
        APIManger.shared.newsAllRequest { result in
            switch result {
            case .success(let news):
                newsList = news
                print("success: \(news)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
