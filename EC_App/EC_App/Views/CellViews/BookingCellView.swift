import SwiftUI

struct BookingCellView: View {
    var booking: BookingResponse
    @Binding var refetch: Bool
    var body: some View {
        VStack {
            Text(booking.user.email ?? "")
                .bold()
                .padding(.vertical, 5)
            Text(booking.session.number)
                .padding(.vertical, 5)
                .padding(.horizontal, 5)
            Button {
                confirm()
            } label: {
                Text("Подтвердить")
            }.buttonStyle(.bordered)
                .padding()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        .background(.gray.opacity(0.1))
        .cornerRadius(20)
        .padding()
    }
    
    private func confirm() {
        APIManger.shared.approveBookingRequest(id: String(booking.id)) { result in
            switch result {
            case .success(_):
                print("Booking approved")
                refetch.toggle()
            case .failure(let error):
                print(error)
            }
        }
    }
}

