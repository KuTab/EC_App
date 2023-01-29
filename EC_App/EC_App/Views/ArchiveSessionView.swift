//
//  ArchiveSessionView.swift
//  EC_App
//
//  Created by Egor Dadugin on 29.01.2023.
//

import SwiftUI

struct ArchiveSessionView: View {
    var body: some View {
        NavigationLink(destination: SessionDetailView()) {
            VStack {
                Text("Title")
                    .bold()
                Text("Session name")
                Text("Date")
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
            .background(.gray.opacity(0.1))
            .cornerRadius(20)
            .padding()
        }.tint(.black)
    }
}

struct ArchiveSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveSessionView()
    }
}
