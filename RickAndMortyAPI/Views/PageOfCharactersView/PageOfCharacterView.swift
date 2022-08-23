//
//  PageOfCharacter.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 16.08.2022.
//

import Foundation
import UIKit
import SnapKit

class PageOfCharacterView: UIView {

    private var backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "portal2")
        return image
    }()

    private(set) lazy var tableEpisods: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(HeaderForPageOfCharacters.self, forHeaderFooterViewReuseIdentifier: "header")
        table.register(CellForPageOfCharacter.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setBackImage()
        setTableEpisods()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        setBackImage()
        setTableEpisods()
    }

    private func setBackImage() {
        backImage.snp.makeConstraints({ maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        })
    }

    private func setTableEpisods() {
        tableEpisods.snp.makeConstraints({ maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.width.equalToSuperview()
        })
    }

    private func setViews() {
        self.addSubview(backImage)
        self.addSubview(tableEpisods)
    }
}
