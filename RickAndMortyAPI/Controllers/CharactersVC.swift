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
    private var urlRequest:String? = "https://rickandmortyapi.com/api/character"
    private var nextPage: String?
    private var prevPage: String?
    private var numOfPages: Int? = 42
    
    private var charactersView: CharactersView {
        return self.view as! CharactersView
    }
    
    
    
    override func loadView() {
        super.loadView()
        self.view = CharactersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextPageAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous", style: .done, target: self, action: #selector(prevPageAction))
        charactersView.tableCharacters.dataSource = self
        charactersView.tableCharacters.delegate = self
        charactersView.refreshControl.addTarget(self, action: #selector(pullDownRefresh), for: UIControl.Event.valueChanged)
        NetworkManager.shared.getJSON(url: urlRequest, complition: {complition in
            DispatchQueue.main.async {
                for i in complition.results {
                    self.characters.append(i)
                }
                self.nextPage = complition.info.next
                self.prevPage = complition.info.prev
                self.checkBarItems()
                self.charactersView.tableCharacters.reloadData()
            }
        })
    }
    
    @objc private func prevPageAction(sender: UIBarButtonItem) {
        guard let prevPageURL = prevPage else { return }
        self.characters.removeAll()
        NetworkManager.shared.getJSON(url: prevPageURL, complition: {complition in
            DispatchQueue.main.async {
                for i in complition.results {
                    self.characters.append(i)
                }
                self.nextPage = complition.info.next
                self.prevPage = complition.info.prev
                self.checkBarItems()
                self.charactersView.tableCharacters.reloadData()
                self.charactersView.tableCharacters.scrollsToTop = true
            }
        })
    }
    
    
    
    @objc private func nextPageAction(sender: UIBarButtonItem) {
        guard let nextPageURL = nextPage else { return }
        self.characters.removeAll()
        navigationItem.leftBarButtonItem?.isEnabled = true
        NetworkManager.shared.getJSON(url: nextPageURL, complition: {complition in
            DispatchQueue.main.async {
                for i in complition.results {
                    self.characters.append(i)
                }
                self.nextPage = complition.info.next
                self.prevPage = complition.info.prev
                self.checkBarItems()
                self.charactersView.tableCharacters.reloadData()
                self.charactersView.tableCharacters.scrollsToTop = true
            }
        })
    }
    
    @objc private func pullDownRefresh(sender: UIRefreshControl) {
        charactersView.refreshControl.endRefreshing()
    }
    
    private func checkBarItems() {
        if nextPage == nil {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
        if prevPage == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
}

extension CharactersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellForCharacter
        cell.setInfo(info: characters[indexPath.row])
        return cell
    }
}

extension CharactersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageOfCharacter = PageOfCharacterVC()
        pageOfCharacter.setInfo(info: characters[indexPath.row])
        pageOfCharacter.getEpisodes(episods: characters[indexPath.row].episode)
        navigationController?.pushViewController(pageOfCharacter, animated: true)
    }
}


