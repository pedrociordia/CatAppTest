//
//  LoginView.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 3/08/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = ViewModel()
    @AppStorage("isUserSignedIn") var isUserSignedIn = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField : Bool = false
    @State private var editingPasswordTextField : Bool = false
    @FocusState private var focusedField: FocusFieldEnum?
    
    var body: some View {
        
        ZStack {
            ImageBackgroundView(imageName: "mockCat")
            
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Log In")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.black)

                 
                    HStack(spacing: 12.0) {
                        TextField("Email", text: $email){ isEditing in
                            editingEmailTextField = isEditing
                            editingPasswordTextField = false
                        }
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .shadow(color: .gray, radius: 15)

                        .focused($focusedField, equals: .email)
                            .onSubmit {
                                self.focusedField = .password
                            }.submitLabel(.next)
                            .colorScheme(.light)
                            .foregroundColor(Color.black.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                            .padding()
                    }.frame(height: 52)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("BlueCat"), lineWidth: 1.0)
                                .blendMode(.overlay)
                        )
                        .background(
                            Color.white
                                .cornerRadius(16.0)
                                .opacity(0.8)
                        )
                    
                    HStack(spacing: 12.0) {
                        SecureField("Password", text: $password)
                            .focused($focusedField, equals: .password)
                            .onSubmit {}
                            .submitLabel(.done)
                            .colorScheme(.light)
                            .foregroundColor(Color.black.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                            .padding()
                            
                    }.frame(height: 52)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("BlueCat"), lineWidth: 1.0)
                                .blendMode(.overlay)
                        )
                        .background(
                            Color.white
                                .cornerRadius(16.0)
                                .opacity(0.8)
                        ).onTapGesture {
                            editingPasswordTextField = true
                            editingEmailTextField = false
                        }
                    
                    HStack {
                        Spacer()
                        Button {
                            vm.loginUser(email: email, password: password)
                        } label: {
                            Text("Log In")
                                .frame(width: 200)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color("BlueCat"), in: RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .gray, radius: 15)
                        Spacer()
                    }
                }
                .padding(20)
            }
            .alert(isPresented: $vm.hasError, error: vm.error) { }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("BlueCat").opacity(0.2))
                    .background(Color.white.opacity(0.5))
                    .shadow(color: Color("BlueCat").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding()
            
            if vm.isRefreshing {
                
                ProgressView()
                    .scaleEffect(3)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
