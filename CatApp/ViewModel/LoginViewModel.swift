//
//  LoginViewModel.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 3/08/22.
//

import Foundation
import SwiftUI

extension LoginView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var hasError = false
        @Published var error: CustomError?
        @Published private(set) var isRefreshing = false
        @AppStorage("isUserSignedIn") var isUserSignedIn = false
        
        private let client = CombineClient()
        
        func loginUser(email: String, password: String) {
            
            hasError = false
            
            if email == "" || password == "" {
                error = .string(msm: "Some fields are missing.")
                self.hasError.toggle()
                return
            }
            
            withAnimation {
                self.isRefreshing.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                let isValid = self.client.loginUser(LoginModel(email: email, password: password))
                
                withAnimation {
                    self.isRefreshing.toggle()
                }
                
                if isValid {
                    self.isUserSignedIn = true
                } else {
                    self.error = .string(msm: "Invalid User.")
                    self.hasError.toggle()
                }
                
            }
            
        }
    }
    
}
