//
//  HeaderForCharactersInEpisod.swift
//  RickAndMortyAPI
//
//  Created by Оливер Салихов on 21.08.2022.
//

import Foundation
import UIKit

final class HeaderForCharactersInEpisod: UITableViewHeaderFooterView {
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewCenter = NSLayoutConstraint()
    private var imageViewWidth = NSLayoutConstraint()
    private var containerViewHeight = NSLayoutConstraint()
    
    public let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "episod")
        img.contentMode = .scaleToFill
        return img
    }()

    private(set) var containerView = UIView()
    
    private var viewForInfo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.clipsToBounds = true
        return view
    }()

    private(set) lazy var episodName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Times New Roman", size: 20)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.backgroundColor = .clear
        return lbl
    }()

    private(set) lazy var episodAirData: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 255/187, green: 255/186, blue: 255/186, alpha: 1)
        lbl.font = UIFont(name: "Times New Roman", size: 16)
        lbl.backgroundColor = .clear
        return lbl
    }()

    private(set) lazy var episod: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 255/187, green: 255/186, blue: 255/186, alpha: 1)
        lbl.font = UIFont(name: "Times New Roman", size: 16)
        lbl.backgroundColor = .clear
        return lbl
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViews()
        setConteinerViewWithImage()
        setInfoView()
        setNumOfEpisod()
        setAirDataEpisod()
        setEpisodName()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        setConteinerViewWithImage()
        setInfoView()
        setNumOfEpisod()
        setAirDataEpisod()
        setEpisodName()
    }
    
    private func setConteinerViewWithImage() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewCenter = imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        imageViewCenter.isActive = true
        imageViewWidth = imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor)
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }

    private func setInfoView() {
        self.viewForInfo.snp.makeConstraints({maker in
            maker.height.equalTo(65)
            maker.width.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.left.equalToSuperview()
        })
    }

    private func setEpisodName() {
        self.episodName.snp.makeConstraints({maker in
            maker.top.equalToSuperview().inset(5)
            maker.left.equalToSuperview().inset(2)
            maker.height.equalTo(16)
        })
    }

    private func setAirDataEpisod() {
        self.episodAirData.snp.makeConstraints({maker in
            maker.left.equalToSuperview().inset(2)
            maker.top.equalTo(episodName.snp.bottom).offset(5)
            maker.height.equalTo(14)
        })
    }

    private func setNumOfEpisod() {
        self.episod.snp.makeConstraints({ maker in
            maker.left.equalToSuperview().inset(2)
            maker.top.equalTo(episodAirData.snp.bottom).offset(4)
            maker.height.equalTo(14)
        })
    }

    private func setViews() {
        self.addSubview(containerView)
        self.containerView.addSubview(imageView)
        self.containerView.addSubview(viewForInfo)
        self.viewForInfo.addSubview(episodName)
        self.viewForInfo.addSubview(episodAirData)
        self.viewForInfo.addSubview(episod)
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewCenter.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageView.layer.cornerRadius = -offsetY*0.9
        imageViewHeight.constant = offsetY + scrollView.contentInset.top
        imageViewWidth.constant = min(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
