//
//  HomeView.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 23/03/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
          FirstScreenView()
            .tabItem {
              Label("Pic of the Day", systemImage: "camera")
            }
            ItemsView()
            .tabItem {
              Label("Rovers", systemImage: "network")
            }
        } 
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
