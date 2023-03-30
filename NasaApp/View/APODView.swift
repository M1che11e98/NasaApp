//
//  APODView.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 21/03/23.
//

import SwiftUI

struct APODView: View {
    @ObservedObject var vm: APODViewModel
    //    @StateObject private var vm2 = LibraryViewModel()
    
    
    var body: some View {
        
        VStack {
            if !vm.apod.isEmpty {
                TabView{
                    ForEach(vm.apod) { apod in
                        VStack(alignment: .leading) {
                            Text(apod.title)
                                .foregroundColor(.white)
                                .font(.title3)
                                .padding(.all)
                            Spacer()
                            AsyncImage(url: URL(string: apod.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                //.aspectRatio(1.0, contentMode: .fit)
//                                    .frame(height: 270)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                            Text(apod.explanation)
                                .font(.caption2)
                                .foregroundColor(.white)
                                .lineLimit(13)
                                .minimumScaleFactor(0.5)
                                .padding(.horizontal)
//                                .background(Color.black.opacity(0.5))
                            
                            
                            
                            Spacer()
                        } .background(.black)
                            .cornerRadius(6)
                            .padding(.horizontal, 3)
                        
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
            }
            
        }
        
        .task {
            do {
                try await vm.getAPOD()
            } catch {
                print("Error", error)
            }
        }
        
    }
}

struct APODView_Previews: PreviewProvider {
    static var previews: some View {
        APODView(vm: APODViewModel())
    }
}
