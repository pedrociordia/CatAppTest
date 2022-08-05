//
//  ListItemView.swift
//  CatApp
//
//  Created by Pedro Ciordia Cagigal on 3/8/22.
//

import SwiftUI

struct ListItemView: View {
    
    var cat: CatBreedsModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: cat.image?.url ?? "")) {
                $0.resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 70)
                    .cornerRadius(4)
                    .shadow(color: Color("BlueCat").opacity(0.3), radius: 10)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 70)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(cat.name ?? "")
                    .font(.headline)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(2)
                    .foregroundColor(Color("BlueCat"))
                
                Text(cat.description ?? "")
                    .font(.footnote)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }
            Image(systemName: "arrow.right.circle")
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(cat: CatBreedsModel()).preferredColorScheme(.dark)
    }
}
