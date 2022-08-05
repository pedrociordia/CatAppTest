//
//  LazyView.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 3/08/22.
//

import SwiftUI

struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
       self.content()
    }
}

struct LazyView_Previews: PreviewProvider {
    static var previews: some View {
        LazyView(content: {Text("Hello")})
    }
}
