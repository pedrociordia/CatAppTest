//
//  BackgroundView.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 2/8/22.
//

import SwiftUI

struct ImageBackgroundView: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}
