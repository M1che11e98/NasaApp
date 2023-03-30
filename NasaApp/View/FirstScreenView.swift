//
//  ScreenView.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 23/03/23.
//

import SwiftUI

struct FirstScreenView: View {
    @StateObject private var vm = APODViewModel()
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
                APODView(vm: vm)
                //}
         
            }
            .onChange(of: vm.selectedDate, perform: { newValue in
                Task { @MainActor in
                    try await vm.getAPOD()
                }
            })
            .navigationTitle("Pic of the Day")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DatePicker(selection: $vm.selectedDate, in: ...Date.now, displayedComponents: .date) {
                                    Text("Select a date")
                                }
                }
            }
        }
      
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreenView()
    }
}
