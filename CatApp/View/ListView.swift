//
//  ListView.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 3/8/22.
//

import SwiftUI

struct ListView: View {
    
    @AppStorage("isUserSignedIn") var isUserSignedIn = false
    @StateObject var vm = ViewModel()
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                let filter = vm.model.filter{( self.searchText.isEmpty ? true : $0.origin?.localizedCaseInsensitiveContains(self.searchText) ?? true )}
                if filter.count > 0 {
                    ForEach(filter, id:\.id) {cat in
                        NavigationLink {
                            LazyView {
                                DetailView(name: cat.name ?? "", image: cat.image?.url ?? "")
                            }
                        } label: {
                            ListItemView(cat: cat)
                        }
                        Divider()
                            .padding(.horizontal)
                    }
                } else {
                    Text("Not found cats breeds")
                }
            }
            .navigationTitle("Cat Breeds")
            .toolbar {
                ToolbarItem {
                    Button {
                        isUserSignedIn = false
                    } label: {
                        Image(systemName: "escape")
                    }

                }
            }
            .background(Color.black)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Filter by country. (Austria, Egypt, United States)"))
        }
        .alert(isPresented: $vm.hasError, error: vm.error) { }
        .onAppear() {
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            vm.getCatBreeds()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(.dark)
    }
}
