//
//  SessionHistoryView.swift
//  EC_App
//
//  Created by Egor Dadugin on 29.01.2023.
//

import SwiftUI

struct SessionHistoryView: View {
    var body: some View {
        VStack {
            Text("Мои сессии")
                .font(.system(size: 25))
                .bold()
            
            ScrollView {
                ForEach(1..<10) {_ in
                    ArchiveSessionView()
                }
            }
        }
    }
}

struct SessionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SessionHistoryView()
    }
}
