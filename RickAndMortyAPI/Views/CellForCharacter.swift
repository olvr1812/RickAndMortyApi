//
//  cellForCharacter.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 15.08.2022.
//

import Foundation
import UIKit

class CellForCharacter: UITableViewCell {
    
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    private lazy var loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    private lazy var characterName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.01
        return lbl
    }()
    
    private lazy var characterSpecies: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        return lbl
    }()
    
    
    private lazy var characterStatus: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
        setViews()
        setAvatar()
        setCharecterName()
        setCharecterSpecies()
        setCharecterStatus()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCell()
        setViews()
        setAvatar()
        setCharecterName()
        setCharecterSpecies()
        setCharecterStatus()
    }
    
    func setInfo(info: Result) {
        characterName.text = "Name: \(info.name)"
        characterSpecies.text = "Species: \(info.species)"
        characterStatus.text = "Status: \(info.status)"
        characterName.numberOfLines = 2
        avatar.downloaded(from: info.image)
    }
    
    private func setAvatar() {
        avatar.snp.makeConstraints({maker in
            maker.width.equalTo(200)
            maker.height.equalTo(200)
            maker.top.equalToSuperview().inset(10)
            maker.left.equalToSuperview().inset(10)
        })
    }
    
    private func setCharecterName() {
        characterName.snp.makeConstraints({maker in
            maker.top.equalToSuperview().inset(10)
            maker.right.equalToSuperview().inset(10)
            maker.height.equalTo(20)
            maker.width.equalTo(150)
        })
    }
    
    private func setCharecterSpecies() {
        characterSpecies.snp.makeConstraints({maker in
            maker.top.equalTo(characterName).inset(30)
            maker.right.equalToSuperview().inset(10)
            maker.height.equalTo(20)
            maker.width.equalTo(150)
        })
    }
    
    private func setCharecterStatus() {
        characterStatus.snp.makeConstraints({maker in
            maker.top.equalTo(characterSpecies).inset(30)
            maker.right.equalToSuperview().inset(10)
            maker.height.equalTo(20)
            maker.width.equalTo(150)
        })
    }
    
    private func setIndicator() {
        loadIndicator.snp.makeConstraints( {maker in
            maker.height.equalTo(avatar)
            maker.width.equalTo(avatar)
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    private func setViews() {
        self.addSubview(avatar)
        self.addSubview(characterName)
        self.addSubview(characterSpecies)
        self.addSubview(characterStatus)
    }
    
    private func setCell() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
    }
    
}
