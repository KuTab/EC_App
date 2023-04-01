import SwiftUI

struct SessionResponseView: View {
    @State var responsesList: [BookingResponse] = []
    @State var refetch: Bool = false
    
    var body: some View {
        VStack {
            Text("Бронирования")
                .font(.system(size: 25))
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            ScrollView {
                ForEach(responsesList, id: \.self) { booking in
                    BookingCellView(booking: booking, refetch: $refetch)
                }
            }
        }.onAppear(perform: fetchBookings)
            .onChange(of: refetch) { newValue in
                if newValue {
                    fetchBookings()
                }
                refetch = false
            }
    }
    
    private func fetchBookings() {
        APIManger.shared.getBookingsRequest { result in
            switch result {
            case .success(let bookings):
                responsesList = bookings
                print("get bookings")
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct SessionResponseView_Previews: PreviewProvider {
    static var previews: some View {
        SessionResponseView()
    }
}
