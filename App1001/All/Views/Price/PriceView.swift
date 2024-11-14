//
//  PriceView.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct PriceView: View {
    
    @StateObject var viewModel = PriceViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Price list")
                        .foregroundColor(.black)
                        .font(.system(size: 32, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCat = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(12)
                            .background(Circle().fill(Color("prim2")))
                    })
                    
                }
                .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        ForEach(viewModel.categories, id: \.self) { index in
                        
                            Text(index)
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                                .padding(6)
                                .padding(.horizontal, 5)
                                .background(RoundedRectangle(cornerRadius: 5).fill(Color("bg2")))
                        }
                    }
                }
                .frame(height: 20)
                .padding(.bottom)
                
                HStack {
                    
                    Text("Staff")
                        .foregroundColor(.black)
                        .font(.system(size: 32, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(12)
                            .background(Circle().fill(Color("prim2")))
                    })
                    
                }
                .padding(.bottom, 22)
                
                if viewModel.prices.isEmpty {
                    
                    VStack(spacing: 8) {
                        
                        Text("Empty")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .semibold))
                        
                        Text("Click the button above to add first person")
                            .foregroundColor(.black.opacity(0.6))
                            .font(.system(size: 14, weight: .regular))
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.prices, id: \.self) { index in
                            
                                HStack {
                                    
                                    Text(index.prName ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 17, weight: .regular))
                                    
                                    Spacer()
                                    
                                    Text("$\(index.prPrice ?? "")")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .bold))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 18).fill(Color("bg2")))
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddCat ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCat = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                                            
                        Text("Add category")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .semibold))
                            .padding()
                        
                    Text("Title")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ZStack(content: {
                        
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.addingCategory.isEmpty ? 1 : 0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("", text: $viewModel.addingCategory)
                            .foregroundColor(Color.black)
                            .font(.system(size: 14, weight: .medium))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    .padding(.bottom)

                    Button(action: {

                        viewModel.categories.append(viewModel.addingCategory)
                        
                        viewModel.addingCategory = ""
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCat = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                    })
                    .opacity(viewModel.addingCategory.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.addingCategory.isEmpty ?  true : false)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .offset(y: viewModel.isAddCat ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
        )
        .onAppear {
            
            viewModel.fetchPrices()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddPrice(viewModel: viewModel)
        })
    }
}

#Preview {
    PriceView()
}
