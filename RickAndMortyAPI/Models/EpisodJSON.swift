//
//  EpisodJSON.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 16.08.2022.
//

import Foundation

struct CharactersInEpisod: Decodable {
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
}
