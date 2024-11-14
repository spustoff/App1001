//
//  HomeView.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {

        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Home")
                        .foregroundColor(.black)
                        .font(.system(size: 32, weight: .bold))
                    
                    Spacer()
                    
                    Menu(content: {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPhoto = true
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Text("Add image")
                                
                                Spacer()
                                
                                Image(systemName: "photo")
                            }
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Text("Add schedule")
                                
                                Spacer()
                                
                                Image(systemName: "doc.text")
                            }
                        })
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(12)
                            .background(Circle().fill(Color("prim2")))
                    })

                }
                .padding(.bottom, 22)
                
                ScrollView(.horizontal, showsIndicators: false) {

                        LazyHStack {
                            
                            ForEach(viewModel.images, id: \.self) { index in
                            
                                Image(index)
                                    .resizable()
                                    .frame(width: 260, height: 150)

                            }
                        }
                }
                .frame(height: 160)
                .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        ForEach(viewModel.daysOfWeek, id: \.self) { index in
                        
                            Button(action: {
                                
                                viewModel.currentDayOfWeek = index
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(.black)
                                    .font(.system(size: 19, weight: .medium))
                                    .frame(width: 70, height: 35)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color("prim2").opacity(viewModel.currentDayOfWeek == index ? 1 : 0)))
                            })
                        }
                    }
                }
                .frame(height: 40)
                .opacity(viewModel.schedules.isEmpty ? 0 : 1)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    if viewModel.schedules.isEmpty {
                        
                        Text("Empty")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .semibold))
                            .padding(.top, 100)
                        
                        Text("Click the button above to add photos or schedule")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.center)
                            .padding(.top, 3)
                        
                    } else {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
    
                            ForEach(viewModel.schedules.filter{($0.scDay ?? "") == viewModel.currentDayOfWeek}, id: \.self) { index in
            
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    HStack {
                                        
                                        Text("\(index.scStTime ?? "")-\(index.scFinTime ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 17, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                            viewModel.selectedSched = index
                                            
                                            withAnimation(.spring()) {
                                                
                                                viewModel.isDelete = true
                                            }
                                            
                                        }, label: {
                                            
                                            Image(systemName: "trash.fill")
                                                .foregroundColor(Color("prim2"))
                                                .font(.system(size: 17, weight: .semibold))
                                        })
                                    }
                                    
                                    Spacer()
    
                                    Text(index.scName ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold))
                                    
                                    HStack {
                                        
                                        Image("3")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20)
                                        
                                        Text(index.scTeach ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .regular))
                                     
                                        Spacer()
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 120)
                                .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("bg2")))
                            }
                        })
                }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchScheds()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddSchedule(viewModel: viewModel)
        })
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
                    
                    Text("Delete schedule")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.black.opacity(0.7))
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteScName(withScName: viewModel.selectedSched?.scName ?? "", completion: {
                            
                            viewModel.fetchScheds()
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
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddPhoto ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddPhoto = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPhoto = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    ZStack {
                        
                        Text("Add photos")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .semibold))
                            .padding()
                     
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
                                viewModel.images.append(viewModel.currentPhoto)
                                
                                viewModel.currentPhoto = ""
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddPhoto = false
                                }
                                
                            }, label: {
                                
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 18, weight: .regular))
                            })
                        }
                    }

                    HStack {
                        
                        ForEach(viewModel.photos, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.currentPhoto = index
                                
                            }, label: {
                                
                                Image(index)
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                    .padding(3)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim2").opacity(viewModel.currentPhoto == index ? 1 : 0)))
                                    .padding(2)
                            })
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .offset(y: viewModel.isAddPhoto ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
        )
    }
}

#Preview {
    HomeView()
}
