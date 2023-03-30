//
//  SearchBarView.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 26/03/23.
//

import SwiftUI

struct SearchBarView: View {
    
//    @ObservedObject var vm = LibraryViewModel()
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            
            TextField("Search your topic...", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        Button(action: {
                            searchText = ""
                            
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .opacity(searchText == "" ? 0.0 : 1.0)
                                .padding(.trailing, 16)
                        }
                    })
                .submitLabel(.search)
        }
    }
}
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
