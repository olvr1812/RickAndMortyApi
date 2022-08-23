//
//  CharactersInEpisod.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 16.08.2022.
//

import Foundation
import UIKit

class CharactersInEpisodView: UIView {

    private(set) lazy var tableCharactersInEpisod: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(CellForCharactersInEpisod.self, forCellReuseIdentifier: "cell")
        table.register(HeaderForCharactersInEpisod.self, forHeaderFooterViewReuseIdentifier: "header")
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setTableCharactersInEpisod()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        setTableCharactersInEpisod()
    }

    private func setTableCharactersInEpisod() {
        tableCharactersInEpisod.snp.makeConstraints({maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        })
    }

    private func setViews() {
        self.addSubview(tableCharactersInEpisod)
    }
}
