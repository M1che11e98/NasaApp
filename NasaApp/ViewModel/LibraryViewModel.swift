//
//  LibraryViewModel.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 25/03/23.
//

import Foundation

@MainActor
class LibraryViewModel: ObservableObject {
    
    @Published var library: LibraryModel? = nil
    @Published var searchText: String = ""
    let libraryArray: [String] = ["moon", "saturn", "hubble", "spaceX", "space"]
    
    private func getLibrary(searchString: String) async throws -> LibraryModel? {
        guard let url = URL(string: "http://images-api.nasa.gov./search?q=\(searchString)&media_type=image") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print("data \(response)")
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        do {
            let library = try JSONDecoder().decode(LibraryModel.self, from: data)
//            print(library)
            return library
        } catch {
            print("error decoding \(error.localizedDescription)")
        }
        return nil
    }
    
    private func fetchImage(libraryModelResult: LibraryModel) async throws -> [Item] {
        return try await withThrowingTaskGroup(of: Item?.self) { group in
            var items: [Item] = []
            for item in libraryModelResult.collection.items {
                group.addTask {
                    if let url = item.links.first?.href {
                        let dataImage = try? await self.fetchImageFromUrl(url: url)
                        let newItemLinks: ItemLink = ItemLink(href: url, imageData: dataImage)
                        let newItem: Item = Item(data: item.data, links: [newItemLinks])
                        
                        return newItem
                    } else { return nil }
                }
            }
            for try await item in group {
                if let item {
                    items.append(item)
                }
            }
            return items
        }
    }
    
    
    func createNewLibrary(searchString: String) async throws {
        library = nil
        print("library start")
        let libraryModelResult = try await  getLibrary(searchString: searchString)
        print("library result \(libraryModelResult)")
        guard let libraryModelResult else { throw URLError(.badURL) }
        let item =  try await fetchImage(libraryModelResult: libraryModelResult)
        print("itemmm \(item)")
        var newLibrary: LibraryModel = libraryModelResult
        newLibrary.collection.items = item
//
        library = newLibrary
//        print("libraryyyyyyyyyy \(newLibrary)")
        
    }
    
    private func fetchImageFromUrl(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
   
    }
    
    
}

