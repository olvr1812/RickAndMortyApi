//
//  CharactersInEpisodVC.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 16.08.2022.
//

import Foundation
import UIKit

class CharactersInEpisodVC: UIViewController {
    private var charactersInEpisodView: CharactersInEpisodView {
        return self.view as! CharactersInEpisodView
    }
    
    private var episodURL: String?
    private var charactersInEpisod: [String] = []
    
    override func loadView() {
        super.loadView()
        self.view = CharactersInEpisodView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersInEpisodView.tableCharactersInEpisod.dataSource = self
        NetworkManager.shared.getCharacters(url: episodURL, complition: {complition in
            DispatchQueue.main.async {
                for i in complition.characters {
                    self.charactersInEpisod.append(i)
                }
                self.charactersInEpisodView.tableCharactersInEpisod.reloadData()
            }
        })
    }
    
    func episodURL(url: String) {
        episodURL = url
    }
}

extension CharactersInEpisodVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersInEpisod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = charactersInEpisod[indexPath.row]
        return cell
    }
    
    
}
