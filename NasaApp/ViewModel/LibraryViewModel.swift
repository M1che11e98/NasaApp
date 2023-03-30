//
//  LibraryViewModel.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 25/03/23.
//

import Foundation


//Use MainActor to update the view in the main thread
@MainActor
class LibraryViewModel: ObservableObject {
    
    @Published var library: LibraryModel? = nil
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    
    //This function get the data from API and decode into LibraryModel
    private func getLibrary(searchString: String) async throws -> LibraryModel? {
        guard let url = URL(string: "http://images-api.nasa.gov./search?q=\(searchString)&media_type=image") else { throw MyError.runtimeError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print("data \(response)")
    //Check the response with the HTTP status code, if the result is 200 return the LibraryModel otherwise throw an error
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MyError.runtimeError("Error while fetching data") }
        do {
            let library = try JSONDecoder().decode(LibraryModel.self, from: data)
//            print(library)
            return library
        } catch {
            print("error decoding \(error.localizedDescription)")
        }
        return nil
    }
    
/*
This function use Task Group to download more images, starting multiple task at the same time and return all the images only when all the tasks are completed.
In this specific case because the structure of the model cotains an array of URLs but with only one element inside we need to create a constant to store the
 URL of the element. So, for each item (that contain URL and data of the image) we called the method fetchImageFromUrl(url: String) and create a new item with
 the result of our request.
 At the end we have another cycle to return the items from the group.
 */
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
    
/*
 Final function called in the Task of the View.
 First call the getLibrary method to the a specific image Library from a user searched topic (searchText in the variable associated to the search bar)
 Once received we can call the fetchImage method to fill the library with the missing image data.
 And finally we can return a new library with all the data.
 */
    func createNewLibrary() async throws {
        library = nil
        isLoading = true
        print("library start")
        let libraryModelResult = try await  getLibrary(searchString: searchText)
        print("library result \(libraryModelResult)")
        guard let libraryModelResult else { throw MyError.runtimeError("Error getting library") }
        let item =  try await fetchImage(libraryModelResult: libraryModelResult)
        print("item \(item)")
        var newLibrary: LibraryModel = libraryModelResult
        newLibrary.collection.items = item
        
        library = newLibrary
        isLoading = false
        
    }
    
    
//Fetch an image from a URL and return the Data (the final image will be created in the View)
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
    
//Custom throwing error
    enum MyError: Error {
        case runtimeError(String)
    }
}

