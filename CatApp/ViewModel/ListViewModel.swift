//
//  ListViewModel.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 3/08/22.
//

import Foundation
import Combine

extension ListView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var model = [CatBreedsModel]()
        @Published var hasError = false
        @Published var error: CustomError?
        @Published private(set) var isRefreshing = false
        
        private var cancellable: AnyCancellable?
        private let client = CombineClient()
        
        
        func getCatBreeds() {
            
            hasError = false
            isRefreshing = true
            
            cancellable = client.fetchAllCatBreeds()
                .sink(receiveCompletion: { res in
                    self.isRefreshing.toggle()
                    switch res {
                    case .failure(let error):
                        self.hasError.toggle()
                        self.error = error
                    default: break
                    }
                    
                }, receiveValue: {
                    self.model = $0
                })
            
        }
    }
}
