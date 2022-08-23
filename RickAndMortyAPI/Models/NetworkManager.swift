//
//  character.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 15.08.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getJSON(url: String?, complition: @escaping(Characters) -> Void) {
        guard let urlRequest = url, let request = URL(string: urlRequest) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return }
            
            guard let json = data else { return }
            
            do {
                let charactersJSON = try JSONDecoder().decode(Characters.self, from: json)
                complition(charactersJSON)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getEpisodInfo(url: String?, complition: @escaping(CharactersInEpisod) -> Void) {
        guard let urlRequest = url, let request = URL(string: urlRequest) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return }
            guard let json = data else { return }
            
            do {
                let charactersJSON = try JSONDecoder().decode(CharactersInEpisod.self, from: json)
                complition(charactersJSON)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getCharacter(url: String?, complition: @escaping(Result) -> Void) {
        guard let urlRequest = url, let request = URL(string: urlRequest) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return }
            guard let json = data else { return }
            
            do {
                let charactersJSON = try JSONDecoder().decode(Result.self, from: json)
                complition(charactersJSON)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
