//
//  NewsCVC.swift
//  NewsApplication
//
//  Created by Nimap on 22/02/24.
//

import UIKit

class NewsCVC: UICollectionViewCell {
    
    var mainView : UIView!
    var titleLabel: UILabel!
    var stackView : UIStackView!
    var Image : UIImageView!
    var Description: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func CellUI(){
        contentView.backgroundColor = .clear
        
        mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 4.0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 4.0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -4.0),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -4.0)
        ])
        
        Image = UIImageView()
        Image.contentMode = .scaleAspectFill
        Image.layer.cornerRadius = 10
        Image.layer.masksToBounds = true
        Image.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(Image)
        NSLayoutConstraint.activate([
            Image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0.0),
            Image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0.0),
            Image.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0.0),
            Image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0.0)
        ])
        
        stackView = UIStackView()
        stackView.layer.cornerRadius = 10
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        Image.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15.0),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15.0),
            stackView.topAnchor.constraint(equalTo: Image!.bottomAnchor, constant: -90.0),
            stackView.heightAnchor.constraint(equalToConstant: 80.0)

        ])
        
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        Description = UILabel()
        Description.text = "Title"
        Description.textColor = .white
        Description.numberOfLines = 3
        Description.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(Description)
        NSLayoutConstraint.activate([
            
        ])
    }
}
