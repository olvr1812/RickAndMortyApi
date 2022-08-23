//
//  Characters.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 15.08.2022.
//

import Foundation

struct Characters: Decodable {
    let results: [Result]
    let info: Info
}

struct Result: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let episode: [String]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}
