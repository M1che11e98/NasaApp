//
//  ItemsView.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 25/03/23.
//

import SwiftUI
import UIKit

struct ItemsView: View {
    
    @StateObject private var vm = LibraryViewModel()
//    @Binding var searchText: String
    
     
    
    let columns = [GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            SearchBarView(searchText: $vm.searchText)
                .onSubmit {
                    Task {
                        try await vm.createNewLibrary(searchString: vm.searchText)
                    }
                }

            ScrollView {
                if let library = vm.library, let items = library.collection.items {
        
                   VStack {
                        
                        ForEach(items) { item in
                            if let link = item.links.first, let imageData = link.imageData {
                                if let image = UIImage(data: imageData) {
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
              }
        
            }
            
        }
//        .task {
//            try? await vm.createNewLibrary(searchString: vm.searchText)
//        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
