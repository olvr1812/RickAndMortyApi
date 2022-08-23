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
        guard let rootView = self.view as? CharactersInEpisodView else { return CharactersInEpisodView() }
        return rootView
    }
    
    private var infoInEpisod: CharactersInEpisod?
    private var characters: [String]?
    private var character: [Result]?
    private var names: [String] = []
    private var avatars: [String] = []
    
    override func loadView() {
        super.loadView()
        self.view = CharactersInEpisodView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersInEpisodView.tableCharactersInEpisod.dataSource = self
        charactersInEpisodView.tableCharactersInEpisod.delegate = self
        charactersInEpisodView.tableCharactersInEpisod.reloadData()
        if let characters = characters {
            for character in characters {
                NetworkManager.shared.getCharacter(url: character, complition: { complition in
                    DispatchQueue.main.async {
                        self.names.append(complition.name)
                        self.avatars.append(complition.image)
                        self.charactersInEpisodView.tableCharactersInEpisod.reloadData()
                    }
                })
            }
        }
    }
    
    func getCahracters(episodInfo: CharactersInEpisod) {
        infoInEpisod = episodInfo
        characters = episodInfo.characters
    }
}

extension CharactersInEpisodVC: UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CellForCharactersInEpisod
        else { return CellForCharactersInEpisod() }
        cell.avatar.downloaded(from: avatars[indexPath.row])
        cell.nameCharacter.text = names[indexPath.row]
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HeaderForCharactersInEpisod,
            let name = infoInEpisod?.name,
            let airData = infoInEpisod?.air_date,
            let episod = infoInEpisod?.episode
        else { return HeaderForCharactersInEpisod() }
        header.episodName.text = name
        header.episodAirData.text = airData
        header.episod.text = episod
        return header
    }
}

extension CharactersInEpisodVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UIScreen.main.bounds.width * 0.7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

//extension CharactersInEpisodVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let header = charactersInEpisodView.tableCharactersInEpisod.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HeaderForCharactersInEpisod else { return }
//        header.scrollViewDidScroll(scrollView: charactersInEpisodView.tableCharactersInEpisod)
//    }
//}
