//
//  PageOfCharacterVC.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 16.08.2022.
//

import Foundation
import UIKit

class PageOfCharacterVC: UIViewController {
    var episodsOfCharacter: [CharactersInEpisod] = []
    var characterInfo: Result?
    var charactersInEpisod: [String]?
    private var avatarImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private var pageOfCharacterView: PageOfCharacterView {
        if let pageView = self.view as? PageOfCharacterView {
            return pageView
        } else { return PageOfCharacterView() }
    }
    
    override func loadView() {
        super.loadView()
        self.view = PageOfCharacterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageOfCharacterView.tableEpisods.dataSource = self
        pageOfCharacterView.tableEpisods.delegate = self
        guard let episods = characterInfo?.episode else { return }
        for episod in episods {
            NetworkManager.shared.getEpisodInfo(url: episod, complition: {complition in
                DispatchQueue.main.async {
                    print("work")
                    self.episodsOfCharacter.append(complition)
                    print(complition.name)
                    self.pageOfCharacterView.tableEpisods.reloadData()
                }
            })
        }
        pageOfCharacterView.tableEpisods.reloadData()
        let header = HeaderForPageOfCharacters(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        headerSets(header: header)
        pageOfCharacterView.tableEpisods.tableHeaderView = header
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func setInfo(info: Result) {
        characterInfo = info
    }
    
    func headerSets(header: HeaderForPageOfCharacters) {
        guard let info = characterInfo else { return }
        header.imageView.downloaded(from: info.image)
        header.characterName.text = info.name
        header.characterSpecies.text = ("Species: \(info.species)")
        if info.status == "Alive" {
            header.characterStatus.text = ("Status: \(info.status) 💚")
        } else if info.status == "Dead" {
            header.characterStatus.text = ("Status: \(info.status) 🪦")
        } else {
            header.characterStatus.text = ("Status: \(info.status) ❔")
        }
    }
}

extension PageOfCharacterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodsOfCharacter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CellForPageOfCharacter
        else { return CellForPageOfCharacter() }
        cell.episodName.text = episodsOfCharacter[indexPath.row].name
        cell.episod.text = episodsOfCharacter[indexPath.row].episode
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        let verticalPadding = CGFloat(4)
        let maskLayer = CALayer()
        maskLayer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        maskLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
}

extension PageOfCharacterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = CharactersInEpisodVC()
        rootVC.getCahracters(episodInfo: episodsOfCharacter[indexPath.row])
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.viewWidth
    }
}

extension PageOfCharacterVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = pageOfCharacterView.tableEpisods.tableHeaderView as? HeaderForPageOfCharacters else { return }
        header.scrollViewDidScroll(scrollView: pageOfCharacterView.tableEpisods)
    }
}
