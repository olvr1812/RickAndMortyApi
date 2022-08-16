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
        image.image = UIImage(named: "portal1")
        return image
    }()
    
    private(set) lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.clipsToBounds = true
        image.layer.cornerRadius = 150
        image.layer.borderWidth = 3
        return image
    }()
    
    private lazy var characterName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Times New Roman", size: 20)
        lbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 5
        return lbl
    }()
    
    private lazy var characterSpecies: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Times New Roman", size: 20)
        lbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 5
        return lbl
    }()
    
    
    private lazy var characterStatus: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Times New Roman", size: 20)
        lbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 5
        return lbl
    }()
    
    private(set) lazy var tableEpisods: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setBackImage()
        setAvatar()
        setCharecterName()
        setCharecterSpecies()
        setCharacterStatus()
        setTableEpisods()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        setBackImage()
        setAvatar()
        setCharecterName()
        setCharecterSpecies()
        setCharacterStatus()
        setTableEpisods()
    }
    
    func setInfo(info: Result) {
        characterName.text = "Name: \(info.name)"
        characterSpecies.text = "Species: \(info.species)"
        characterStatus.text = "Status: \(info.status)"
        characterName.numberOfLines = 2
        avatar.downloaded(from: info.image)
    }
    
    private func setBackImage() {
        backImage.snp.makeConstraints({ maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        })
    }
    
    private func setAvatar() {
        avatar.snp.makeConstraints({ maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(100)
        })
    }
    
    private func setCharecterName() {
        characterName.snp.makeConstraints({maker in
            maker.bottom.equalTo(self.avatar).offset(40)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(30)
        })
    }
    
    private func setCharecterSpecies() {
        characterSpecies.snp.makeConstraints({maker in
            maker.bottom.equalTo(characterName).offset(40)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(30)
        })
    }
    
    private func setCharacterStatus() {
        characterStatus.snp.makeConstraints({ maker in
            maker.bottom.equalTo(characterSpecies).offset(40)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(30)
        })
    }
    
    private func setTableEpisods() {
        tableEpisods.snp.makeConstraints({ maker in
            maker.top.equalTo(characterStatus).offset(40)
            maker.width.equalToSuperview()
            maker.bottom.equalToSuperview().inset(0)
        })
    }
    
    private func setViews() {
        self.addSubview(backImage)
        self.addSubview(avatar)
        self.addSubview(characterName)
        self.addSubview(characterSpecies)
        self.addSubview(characterStatus)
        self.addSubview(tableEpisods)
    }
    
    
}
