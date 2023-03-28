//
//  ScreenView.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 23/03/23.
//

import SwiftUI

struct FirstScreenView: View {
    var body: some View {
        NavigationStack {
            VStack {
//                ZStack {
//                    Image("image")
//                        .resizable()
//                        .renderingMode(.template)
//                        .scaledToFit()
//                        .foregroundColor(Color.blue.opacity(0.4))
//                        .frame(width: 180, height: 180)
//                        .padding(.top, 500)
//                        .padding(.leading, 200)
                    APODView()
                //}
         
            }
            .navigationTitle("Pic of the Day")
        }
      
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreenView()
    }
}
