//
//  DetailViewModel.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/08/22.
//

import Foundation
import Combine

extension DetailView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var model =  CatBreedsDetailModel()
        @Published var hasError = false
        @Published var error: CustomError?
        @Published private(set) var isRefreshing = false
        
        private var cancellable: AnyCancellable?
        private let client = CombineClient()
        
        func getCatBreedsDetail(_ name: String) {
            
            hasError = false
            isRefreshing = true
            
            cancellable = client.fetchCatBreedsByName(name.replacingOccurrences(of: " ", with: "+"))
                .sink(receiveCompletion: { res in
                    self.isRefreshing.toggle()
                    switch res {
                    case .failure(let error):
                        self.hasError.toggle()
                        self.error = error
                    default: break
                    }
                }, receiveValue: {
                    self.model = $0.first ?? CatBreedsDetailModel()
                })
        }
    }
}
