//
//  PageOfCharacterVC.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 16.08.2022.
//

import Foundation
import UIKit

class PageOfCharacterVC: UIViewController {
    
    var episodsOfCharacter: [String]?
    
    private var pageOfCharacterView: PageOfCharacterView {
        return self.view as! PageOfCharacterView
    }
    
    override func loadView() {
        super.loadView()
        self.view = PageOfCharacterView()
        self.view.backgroundColor = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageOfCharacterView.tableEpisods.dataSource = self
        pageOfCharacterView.tableEpisods.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        pageOfCharacterView.tableEpisods.delegate = self
    }
    
    func setInfo(info: Result) {
        pageOfCharacterView.setInfo(info: info)
    }
    
    func getEpisodes(episods: [String]) {
        episodsOfCharacter = episods
    }
}

extension PageOfCharacterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countEpisods = episodsOfCharacter?.count else { return 0}
        return countEpisods
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = episodsOfCharacter?[indexPath.row]
        cell?.textLabel?.textColor = .black
        cell?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        return cell!
    }
}

extension PageOfCharacterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("work")
        guard let episods = episodsOfCharacter else { return }
        let rootVC = CharactersInEpisodVC()
        
        rootVC.episodURL(url: episods[indexPath.row])
        print(episods[indexPath.row])
        navigationController?.pushViewController(rootVC, animated: true)
    }
}
