//
//  LoadingView.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Image("Llogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding()
                    .padding(.bottom, 90)
            }
        }
    }
}

#Preview {
    LoadingView()
}
