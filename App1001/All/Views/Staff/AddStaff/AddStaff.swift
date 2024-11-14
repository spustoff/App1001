//
//  AddStaff.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct AddStaff: View {
    
    @StateObject var viewModel: StaffViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New staff")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            viewModel.curAvatar = ""
                            viewModel.currentCategory = ""
                            viewModel.stName = ""
                            viewModel.stProf = ""
                            viewModel.stSal = ""
                            viewModel.stTask = ""
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        ForEach(viewModel.avatars, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.curAvatar = index
                                
                            }, label: {
                                
                                Image(index)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55)
                                    .opacity(viewModel.curAvatar == index ? 1 : 0.5)
                            })
                        }
                    }
                }
                .frame(height: 60)
                .padding(.vertical, 6)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 18) {
                        
                        ZStack(content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.stName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.stName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                        
                        ZStack(content: {
                            
                            Text("Profession")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.stProf.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.stProf)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                        
                        ZStack(content: {
                            
                            Text("Salary")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.stSal.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.stSal)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                        
                        ZStack(content: {
                            
                            Text("Tasks")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.stTask.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.stTask)
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
                    
                    viewModel.stType = viewModel.currentCategory
                    viewModel.stPhoto = viewModel.curAvatar
                    
                    viewModel.addStaff()
                    
                    viewModel.curAvatar = ""
                    viewModel.currentCategory = ""
                    viewModel.stName = ""
                    viewModel.stProf = ""
                    viewModel.stSal = ""
                    viewModel.stTask = ""
                    
                    viewModel.fetchStaffs()
                    
                    
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
                .opacity(viewModel.curAvatar.isEmpty || viewModel.stName.isEmpty || viewModel.stProf.isEmpty ? 0.5 : 1)
                .disabled(viewModel.curAvatar.isEmpty || viewModel.stName.isEmpty || viewModel.stProf.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddStaff(viewModel: StaffViewModel())
}
