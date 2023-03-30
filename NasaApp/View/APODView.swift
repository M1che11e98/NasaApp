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
                        VStack(alignment: .center) {
                            Text(apod.title)
                                .foregroundColor(.black)
                                .font(.title3)
                                .padding(.trailing, 155)
                                AsyncImage(url: URL(string: apod.url))
                                { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
//                                        .clipped()
                                        .aspectRatio(1.0, contentMode: .fit)
//                                        .frame(width: 270, height: 270)
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(apod.explanation)
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .lineLimit(13)
                                    .minimumScaleFactor(0.5)
                                    .background(Color.black.opacity(0.5))
                                    .padding(.trailing, 0.5)
                                    .padding(.leading, 0.5)


                            
                            Spacer()
                        }
                 
                 
                    }
                }  .tabViewStyle(.page)
                
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
