//
//  MoreNews.swift
//  NewsApplication
//
//  Created by Nimap on 23/02/24.
//

import UIKit

class MoreNews: UICollectionViewCell {
    let moreLabel: UILabel = {
            let label = UILabel()
            label.text = "More"
            label.textAlignment = .center
            label.textColor = .white
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            backgroundColor = .clear
            addSubview(moreLabel)

            moreLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                moreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                moreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
}
