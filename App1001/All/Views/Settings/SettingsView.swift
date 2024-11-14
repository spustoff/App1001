//
//  SettingsView.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Settings")
                        .foregroundColor(.black)
                        .font(.system(size: 32, weight: .bold))
                    
                    Spacer()
                    
                }
                .padding(.bottom, 24)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        Button(action: {
                            
                            guard let url = URL(string: "https://www.termsfeed.com/live/832c64c2-1586-4937-9fd6-49a1fb5a07aa") else { return }
                            
                            UIApplication.shared.open(url)
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "person.badge.shield.checkmark.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24, weight: .regular))
                                
                                Text("Usage Policy")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Spacer()
                                
                                Text("Read")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(5)
                                    .padding(.horizontal, 4)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim2")))
                            }
                            .padding()
                            .frame(height: 80)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                        })
                        
                        Button(action: {
                            
                            SKStoreReviewController.requestReview()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(width: 25, height: 25)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.black))
                                
                                Text("Rate us")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Spacer()
                                
                                Text("Rate")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(5)
                                    .padding(.horizontal, 4)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim2")))
                            }
                            .padding()
                            .frame(height: 80)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                        })
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
