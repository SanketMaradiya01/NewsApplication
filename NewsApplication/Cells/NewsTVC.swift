//
//  NewsTVC.swift
//  NewsApplication
//
//  Created by Nimap on 22/02/24.
//

import UIKit

class NewsTVC: UITableViewCell {
    
    var CenterView : UIView!
    var TitleLbl: UILabel!
    var LblStavkView : UIStackView!
    var MainImg : UIImageView!
    var DesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sendSubviewToBack(contentView)
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        CellUI()
        scaleImageToFit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func scaleImageToFit() {
        // Ensure that there is an image in the imageView
        guard let image = MainImg.image else {
            return
        }
        
        // Calculate the aspect ratio of the image
        let aspectRatio = image.size.width / image.size.height
        
        // Set the frame of the imageView to fit the image while maintaining aspect ratio
        if image.size.width > image.size.height {
            let newWidth = MainImg.frame.width
            let newHeight = newWidth / aspectRatio
            MainImg.frame.size = CGSize(width: newWidth, height: newHeight)
        } else {
            let newHeight = MainImg.frame.height
            let newWidth = newHeight * aspectRatio
            MainImg.frame.size = CGSize(width: newWidth, height: newHeight)
        }
    }
    func CellUI(){
        
        self.contentView.backgroundColor = .clear
        
        CenterView = UIView()
        CenterView.backgroundColor = .clear
        CenterView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(CenterView)
        NSLayoutConstraint.activate([
            CenterView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 4.0),
            CenterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 4.0),
            CenterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -4.0),
            CenterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -4.0)
        ])
        
        MainImg = UIImageView()
        MainImg.translatesAutoresizingMaskIntoConstraints = false
        CenterView.addSubview(MainImg)
        MainImg.backgroundColor = .clear
        NSLayoutConstraint.activate([
            MainImg.topAnchor.constraint(equalTo: CenterView.topAnchor),
            MainImg.leadingAnchor.constraint(equalTo: CenterView.leadingAnchor),
            MainImg.trailingAnchor.constraint(equalTo: CenterView.trailingAnchor),
            MainImg.bottomAnchor.constraint(equalTo: CenterView.bottomAnchor)
        ])
        
        LblStavkView = UIStackView()
        LblStavkView.alignment = .fill
        LblStavkView.distribution = .fillProportionally
        LblStavkView.axis = .vertical
        LblStavkView.backgroundColor = .clear
        LblStavkView.translatesAutoresizingMaskIntoConstraints = false
        MainImg.addSubview(LblStavkView)
        NSLayoutConstraint.activate([
            LblStavkView.leadingAnchor.constraint(equalTo: CenterView.leadingAnchor, constant: 10.0),
            LblStavkView.trailingAnchor.constraint(equalTo: CenterView.trailingAnchor, constant: -10.0),
            LblStavkView.topAnchor.constraint(equalTo: MainImg.bottomAnchor, constant: -120.0),
            LblStavkView.heightAnchor.constraint(equalToConstant: 110.0)
            
        ])
        
        TitleLbl = UILabel()
        TitleLbl.text = "Title"
        TitleLbl.textColor = .white
        TitleLbl.font = UIFont.boldSystemFont(ofSize: 20.0)
        TitleLbl.translatesAutoresizingMaskIntoConstraints = false
        LblStavkView.addArrangedSubview(TitleLbl)
        NSLayoutConstraint.activate([
            TitleLbl.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        DesLabel = UILabel()
        DesLabel.text = "Title"
        DesLabel.textColor = .white
        DesLabel.numberOfLines = 2
        DesLabel.translatesAutoresizingMaskIntoConstraints = false
        LblStavkView.addArrangedSubview(DesLabel)
        NSLayoutConstraint.activate([
            
        ])
    }
}
