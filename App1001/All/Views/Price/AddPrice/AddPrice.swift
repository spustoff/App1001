//
//  AddPrice.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct AddPrice: View {

    @StateObject var viewModel: PriceViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Staff")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .medium))
                            
                        })
                        
                        Spacer()

                    }
                }
                .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 18) {

                        ZStack(content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.prName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.prName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))

                        ZStack(content: {
                            
                            Text("Price")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.prPrice.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.prPrice)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                
                                ForEach(viewModel.categories, id: \.self) { index in
                                    
                                    Button(action: {
                                        
                                        viewModel.currentCategory = index
                                        
                                    }, label: {
                                        
                                        Text(index)
                                            .foregroundColor(viewModel.currentCategory == index ? .white : .black)
                                            .font(.system(size: 15, weight: .regular))
                                            .padding(6)
                                            .padding(.horizontal, 5)
                                            .background(RoundedRectangle(cornerRadius: 5).fill(viewModel.currentCategory == index ? Color("prim2") : Color("bg2")))
                                    })
                                }
                            }
                        }
                        .frame(height: 30)

                    }
                }
                
                Button(action: {

                    viewModel.prCat = viewModel.currentCategory
                    
                    viewModel.addPrice()
                    
                    viewModel.prName = ""
                    viewModel.prPrice = ""
                    viewModel.currentCategory = ""
                    
                    viewModel.fetchPrices()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = false
                    }
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                })
                .opacity(viewModel.currentCategory.isEmpty || viewModel.prPrice.isEmpty || viewModel.prName.isEmpty ? 0.5 : 1)
                .disabled(viewModel.currentCategory.isEmpty || viewModel.prPrice.isEmpty || viewModel.prName.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddPrice(viewModel: PriceViewModel())
}
