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
            VStack {
                SearchBarView(searchText: $vm.searchText)
                    .onSubmit {
                        Task {
                            try await vm.createNewLibrary()
                        }
                    }
                if vm.isLoading {
                    Spacer()
                    AnimateGif()
                    Spacer()
                } else if let library = vm.library, let items = library.collection.items {
                    ScrollView {
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
                    Spacer()
                } else {
                    Spacer()
                    VStack(spacing: 10) {
                        Text("Start searching to discover something in the space:")
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                        Text("(Moon, SpaceX, Hubble, Saturn, etc...)")
                            .font(.subheadline)
                    }
                    .foregroundColor(.secondary)
                    
                    .frame(width: 300)
                    Spacer()
                    Image("image")
                        .renderingMode(.template)
                        .foregroundColor(.blue.opacity(0.5))
                }
                
                
            }
            .navigationTitle("Pictures library")
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
