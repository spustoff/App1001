//
//  Rev2.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct Rev2: View {

    @AppStorage("status") var status: Bool = false
    
    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Image("R2")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Text("Streamline operations effortlessly")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Organize your team, adjust pricing, and maintain an updated gym profile with just a few taps.")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Spacer()

                    Button(action: {
                        
                        status = true
                        
                    }, label: {
                        
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                    })
                    
                }
                .padding()
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .frame(height: 330)
                .background(RoundedRectangle(cornerRadius: 0).fill(.white))
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    Rev2()
}
