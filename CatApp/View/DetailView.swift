//
//  DetailView.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/8/22.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm = ViewModel()
    @State var showSafari : Bool = false
    
    var name: String
    var image: String
    
    var body: some View {
        ZStack {
            if vm.isRefreshing {
                ProgressView()
            } else { 
                ScrollView {
                    GeometryReader { geometry in
                        ZStack {
                            ImageBackgroundView(imageName: "mockCat")
                                .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
                            
                            VStack {
                                VStack {
                                    HStack {
                                        Text(vm.model.name ?? "")
                                            .font(.title.bold())
                                        .padding()
                                        Spacer()
                                    }.padding(.top)
                                    
                                    ZStack {
                                        Divider()
                                        HStack {
                                            Spacer()
                                            VStack {
                                                Text("Country Code:")
                                                    .font(.footnote)
                                                Text(vm.model.country_code ?? "").bold().foregroundColor(Color("BlueCat"))
                                            }.padding()
                                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10))
                                            .shadow(color: .brown, radius: 15)
                                            .offset(x: geometry.frame(in: .global).minY > 1 ? -geometry.frame(in: .global).minY : 1)
                                        }.padding()
                                    }
                                    
                                    HStack {
                                        Text(vm.model.description ?? "")
                                            .font(.subheadline)
                                    
                                        .padding()
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Button {
                                            showSafari.toggle()
                                        } label: {
                                            Text("Go to Wikipedia")
                                                .foregroundColor(.black)
                                        }
                                        .padding()
                                        .background(Color("BlueCat"), in: RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .gray, radius: 15)
                                    }
                                    
                                    Spacer()
          
                                }.background(.ultraThinMaterial)
                                    .cornerRadius(50, corners: [.topLeft, .topRight])
                                    .shadow(radius: 10)
                                .offset(y: 100)
                                
                                HStack {
                                    Spacer()
                                    AsyncImage(url: URL(string: image)) {
                                        $0.resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 150)
                                            .clipShape(Circle())
                                            .shadow(radius: 10)
                                            .overlay(Circle().stroke(Color("BlueCat"), lineWidth: 1))
                                            .padding(.horizontal)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 150, height: 150)
                                    }
                                }.offset(y: -700)
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    Divider()
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Temperament:").font(.footnote)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Text(vm.model.temperament?.replacingOccurrences(of: ",", with: " ") ?? "").font(.subheadline).foregroundColor(Color("BlueCat"))
                                }
                            }
                        }.padding()
                    }
                }
            }
        }
        .onAppear() {
            vm.getCatBreedsDetail(name)
        }
        .alert(isPresented: $vm.hasError, error: vm.error) { }
        .fullScreenCover(isPresented: $showSafari) {
            SFSafariViewWrapper(url: URL(string: vm.model.wikipedia_url ?? "")!)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Abyssinian", image: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg").preferredColorScheme(.dark)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
