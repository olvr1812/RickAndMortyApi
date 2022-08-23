//
//  cellForCharactersInEpisod.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 21.08.2022.
//

import Foundation
import UIKit

class CellForCharactersInEpisod: UITableViewCell {
    
    private(set) var avatar: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = 30
        return img
    }()
    
    private(set) var nameCharacter: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Times New Roman", size: 20)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setViews()
        setAvatar()
        setNameCharacter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        setAvatar()
        setNameCharacter()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setViews() {
        self.addSubview(avatar)
        self.addSubview(nameCharacter)
    }
    
   private func setCell() {
        self.snp.makeConstraints({maker in
            maker.height.equalTo(50)
            maker.width.equalToSuperview()
        })
    }
    
    private func setAvatar() {
        self.avatar.snp.makeConstraints({maker in
            maker.width.equalTo(60)
            maker.height.equalTo(60)
            maker.left.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview().inset(5)
        })
    }
    
    private func setNameCharacter() {
        nameCharacter.snp.makeConstraints({maker in
            maker.height.equalTo(20)
            maker.left.equalTo(avatar.snp.right).offset(10)
            maker.centerY.equalToSuperview()
        })
    }
}
