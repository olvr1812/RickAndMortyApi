//
//  CharactersVC.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 15.08.2022.
//

import Foundation
import UIKit

class CharactersVC: UIViewController {

    private var characters: [Result] = []
    private var urlRequest: String? = "https://rickandmortyapi.com/api/character"
    private var nextPage: String?
    private var prevPage: String?
    private var charactersView: CharactersView {
        if let viewChar = self.view as? CharactersView {
            return viewChar
        } else { return CharactersView() }
    }

    override func loadView() {
        super.loadView()
        self.view = CharactersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        charactersView.tableCharacters.dataSource = self
        charactersView.tableCharacters.delegate = self
        
        NetworkManager.shared.getJSON(url: urlRequest, complition: {complition in
            DispatchQueue.main.async {
                for result in complition.results {
                    self.characters.append(result)
                }
                self.nextPage = complition.info.next
                self.prevPage = complition.info.prev
                self.charactersView.tableCharacters.reloadData()
                
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension CharactersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CellForCharacter else { return UITableViewCell() }
        cell.activityIndicator.startAnimating()
        cell.setInfo(info: characters[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = characters.count - 1
        if nextPage != nil && indexPath.row == lastElement {
            NetworkManager.shared.getJSON(url: nextPage, complition: {complition in
                DispatchQueue.main.async {
                    for result in complition.results {
                        self.characters.append(result)
                    }
                    self.nextPage = complition.info.next
                    self.prevPage = complition.info.prev
                    self.charactersView.tableCharacters.reloadData()
                    self.charactersView.tableCharacters.scrollsToTop = true
                }
            })
        }
    }
}

extension CharactersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageOfCharacterVC = PageOfCharacterVC()
        pageOfCharacterVC.setInfo(info: characters[indexPath.row])
        navigationController?.pushViewController(pageOfCharacterVC, animated: true)
    }
}
