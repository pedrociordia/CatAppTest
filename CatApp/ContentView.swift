//
//  ContentView.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isUserSignedIn") var isUserSignedIn = false
    
    var body: some View {
        if isUserSignedIn {
            ListView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
