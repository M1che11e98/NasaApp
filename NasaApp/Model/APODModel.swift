//
//  APODModel.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 21/03/23.
//

import Foundation

struct APODModel: Codable, Identifiable {
    
    var id: String {
        return date
    }
    let copyright: String?
    let date: String
    let explanation: String
    let title: String
    let url: String
}


