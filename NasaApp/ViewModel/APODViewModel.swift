//
//  APODViewModel.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 21/03/23.
//

import Foundation

@MainActor class APODViewModel: ObservableObject {
    @Published var apod: [APODModel] = []
    
    
    func getAPOD() async throws {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?start_date=2023-03-15&end_date=2023-03-23&api_key=vZPwDL3fY3uedonbrpjD6eoefl1EVOkMFCgUcMTm") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
      apod = try JSONDecoder().decode([APODModel].self, from: data)
        print("Async decodedAPOD", apod)
        }

    }
    
    
// HTTPURLResponse restituisce dei codici: 200 = richiesta andata a buon fine, tutto il resto sono errori di vario genere.
