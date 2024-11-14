//
//  Rev1.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct Rev1: View {
    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Image("R1")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Text("Manage your gym with ease")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Easily track staff, update schedules, and manage services all in one place.")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Spacer()

                    NavigationLink(destination: {
                        
                        Rev2()
                            .navigationBarBackButtonHidden()
                        
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
                .background(RoundedRectangle(cornerRadius: 0).fill(Color.white))
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    Rev1()
}
