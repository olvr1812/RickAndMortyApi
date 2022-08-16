//
//  CharactersView.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 15.08.2022.
//

import Foundation
import UIKit
import SnapKit

class CharactersView: UIView {
    
    private var backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "portal2")
        return image
    }()
    
    private(set) lazy var tableCharacters: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(CellForCharacter.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private(set) var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.accessibilityScroll(.up)
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refresh
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setBackImage()
        setTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.insetsLayoutMarginsFromSafeArea = true
        setViews()
        setBackImage()
        setTableView()
    }
    
    private func setBackImage() {
        backImage.snp.makeConstraints( {maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        })
    }
    
    private func setTableView() {
        tableCharacters.snp.makeConstraints({maker in
            maker.top.equalTo(34)
            maker.bottom.equalTo(0)
            maker.width.equalToSuperview()
        })
    }
    
    
    private func setViews() {
        self.addSubview(backImage)
        self.addSubview(tableCharacters)
        tableCharacters.addSubview(refreshControl)
        
    }
    
}
