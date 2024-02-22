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
        scaleImageToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func scaleImageToFit() {
        // Ensure that there is an image in the imageView
        guard let image = Image.image else {
            return
        }
        
        // Calculate the aspect ratio of the image
        let aspectRatio = image.size.width / image.size.height
        
        // Set the frame of the imageView to fit the image while maintaining aspect ratio
        if image.size.width > image.size.height {
            let newWidth = Image.frame.width
            let newHeight = newWidth / aspectRatio
            Image.frame.size = CGSize(width: newWidth, height: newHeight)
        } else {
            let newHeight = Image.frame.height
            let newWidth = newHeight * aspectRatio
            Image.frame.size = CGSize(width: newWidth, height: newHeight)
        }
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
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(Image)
        NSLayoutConstraint.activate([
            Image.topAnchor.constraint(equalTo: mainView.topAnchor),
            Image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            Image.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            Image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        Image.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10.0),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10.0),
            stackView.topAnchor.constraint(equalTo: Image!.bottomAnchor, constant: -120.0),
            stackView.heightAnchor.constraint(equalToConstant: 110.0)

        ])
        
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        Description = UILabel()
        Description.text = "Title"
        Description.textColor = .white
        Description.numberOfLines = 2
        Description.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(Description)
        NSLayoutConstraint.activate([
            
        ])
    }
}
