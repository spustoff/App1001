//
//  StaffView.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct StaffView: View {

    @StateObject var viewModel = StaffViewModel()
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
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
                
                if viewModel.staffs.isEmpty {
                    
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
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                                
                                ForEach(viewModel.staffs, id: \.self) { index in
                                
                                    VStack(alignment: .leading, spacing: 6) {
                                        
                                        HStack {
                                            
                                            Image(index.stPhoto ?? "")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 60)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedStaff = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "trash.fill")
                                                    .foregroundColor(Color("prim2"))
                                                    .font(.system(size: 22, weight: .semibold))
                                            })
                                        }
                                        
                                        Spacer()
                                        
                                        Text(index.stName ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 17, weight: .medium))
                                        
                                        Text(index.stProf ?? "")
                                            .foregroundColor(.black.opacity(0.5))
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 170)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                                }
                        })
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddStaff(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchStaffs()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 13, weight: .regular))
                        })
                    }
                    
                    Text("Delete staff")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteStName(withStName: viewModel.selectedStaff?.stName ?? "", completion: {
                            
                            viewModel.fetchStaffs()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false

                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    StaffView()
}
