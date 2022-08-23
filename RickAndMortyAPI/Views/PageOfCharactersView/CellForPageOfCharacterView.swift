//
//  CellForPageOfCharacterView.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 23.08.2022.
//

import Foundation
import UIKit

class CellForPageOfCharacter: UITableViewCell {
    
    private(set) lazy var episodName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Times New Roman", size: 18)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private(set) lazy var episod: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Times New Roman", size: 18)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setEpisodName()
        setEpisod()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setViews() {
        self.addSubview(episodName)
        self.addSubview(episod)
    }
    
    private func setEpisodName() {
        episodName.snp.makeConstraints({maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(10)
            maker.width.lessThanOrEqualTo(200)
        })
    }
    
    private func setEpisod() {
        episod.snp.makeConstraints({maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(10)
        })
    }

}
