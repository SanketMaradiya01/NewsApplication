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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func CellUI(){
    
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
        MainImg.layer.cornerRadius = 20
        MainImg.contentMode = .scaleToFill
        MainImg.translatesAutoresizingMaskIntoConstraints = false
        CenterView.addSubview(MainImg)
        NSLayoutConstraint.activate([
            MainImg.topAnchor.constraint(equalTo: CenterView.topAnchor, constant: 4),
            MainImg.leadingAnchor.constraint(equalTo: CenterView.leadingAnchor, constant: 4),
            MainImg.trailingAnchor.constraint(equalTo: CenterView.trailingAnchor, constant: -4),
            MainImg.bottomAnchor.constraint(equalTo: CenterView.bottomAnchor, constant: -4)
        ])
        
        LblStavkView = UIStackView()
        LblStavkView.alignment = .fill
        LblStavkView.layer.cornerRadius = 10
        LblStavkView.distribution = .fillProportionally
        LblStavkView.axis = .vertical
        LblStavkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
            TitleLbl.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        
        DesLabel = UILabel()
        DesLabel.text = "Title"
        DesLabel.textColor = .white
        DesLabel.numberOfLines = 4
        DesLabel.translatesAutoresizingMaskIntoConstraints = false
        LblStavkView.addArrangedSubview(DesLabel)
        NSLayoutConstraint.activate([
            
        ])
    }
}
