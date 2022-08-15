//
//  CharactersView.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 15.08.2022.
//

import Foundation
import UIKit

class CharactersView: UIView {
    
    private var backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "portal")
        return image
    }()
    
    private lazy var tableCharacters: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 2
        return tableView
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setBackImage() {
        
    }
    
    
    private func setViews() {
        self.addSubview(backImage)
        self.addSubview(tableCharacters)
    }
    
}
