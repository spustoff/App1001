//
//  AddSchedule.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct AddSchedule: View {

    @StateObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New schedule")
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
                        
                        Text("Information")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack(content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.scName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.scName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))

                        Menu(content: {
                            
                            ForEach(viewModel.daysOfWeek, id: \.self) { index in
                                
                                    Button(action: {
                                        
                                        viewModel.dayOfWeekForAdd = index
                                        
                                    }, label: {
                                        
                                        Text(index)
                                        
                                    })
                            }
                            
                        }, label: {
                            
                            if viewModel.dayOfWeekForAdd.isEmpty {
                                
                                HStack {
                                    
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    Text("Day of the week*")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                    
                                    Spacer()

                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                
                            } else {
                                
                                HStack {
                                    
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    Text(viewModel.dayOfWeekForAdd)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14, weight: .regular))
                                    
                                    Spacer()
         
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            }
                        })
                        
                        HStack {
                            
                            HStack {
                                
                                Image(systemName: "clock")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                ZStack(content: {
                                    
                                    Text("8:15 am")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.scStTime.isEmpty ? 1 : 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    TextField("", text: $viewModel.scStTime)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .medium))
                                    
                                })
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            
                            HStack {
                                
                                Image(systemName: "clock")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                ZStack(content: {
                                    
                                    Text("9:30 pm")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.scFinTime.isEmpty ? 1 : 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    TextField("", text: $viewModel.scFinTime)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .medium))
                                    
                                })
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                        }

                        Text("Teacher")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(content: {
                            
                            Text("Enter name a teacher")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.scTeach.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.scTeach)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))

                    }
                }
                
                Button(action: {
                    
                    viewModel.scDay = viewModel.dayOfWeekForAdd

                    viewModel.addSched()
                    
                    viewModel.scName = ""
                    viewModel.scStTime = ""
                    viewModel.scFinTime = ""
                    viewModel.scTeach = ""
                    viewModel.dayOfWeekForAdd = ""
                    
                    viewModel.fetchScheds()
                    
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
                .opacity(viewModel.scName.isEmpty || viewModel.dayOfWeekForAdd.isEmpty || viewModel.scStTime.isEmpty || viewModel.scFinTime.isEmpty || viewModel.scTeach.isEmpty ? 0.5 : 1)
                .disabled(viewModel.scName.isEmpty || viewModel.dayOfWeekForAdd.isEmpty || viewModel.scStTime.isEmpty || viewModel.scFinTime.isEmpty || viewModel.scTeach.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddSchedule(viewModel: HomeViewModel())
}
