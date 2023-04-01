import SwiftUI

struct NewsAdditionView: View {
    @State var newsList: [New] = testNewList
    @State var creationSheetIsPresented: Bool = false
    @State var refetch: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Text("Новости")
                    .font(.system(size: 25))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button {
                    creationSheetIsPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }.frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
            }
            
            
            ScrollView {
                ForEach(newsList, id: \.self) { new in
                    NewsCellView(new: new)
                }
            }
        }.onAppear(perform: fetchNews)
            .sheet(isPresented: $creationSheetIsPresented) {
                AddNewView(isShowed: $creationSheetIsPresented, refetch: $refetch)
                    .padding(.top)
                    .padding(.horizontal)
            }
            .onChange(of: refetch) { newValue in
                if newValue {
                    fetchNews()
                    refetch = false
                }
            }
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

struct NewsAdditionView_Previews: PreviewProvider {
    static var previews: some View {
        NewsAdditionView()
    }
}
