//
//  AllNewsViewController.swift
//  NewsApplication
//
//  Created by Nimap on 23/02/24.
//

import UIKit

class AllNewsViewController: UIViewController {
    
    var tableView : UITableView!
    var Navbar : UINavigationBar!
    
    var ListData = [ArticleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AccentColor")
        NewsList()
    }
    func NewsList(){
        
        Navbar = UINavigationBar()
        Navbar.backgroundColor = .clear
        Navbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(Navbar)
        NSLayoutConstraint.activate([
            Navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Navbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            Navbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            Navbar.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        let LeftBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(rightButtonTapped))
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = LeftBtn
        Navbar.items = [navigationItem]
        
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTVC.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: Navbar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    @objc func rightButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AllNewsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTVC
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        cell.TitleLbl.text = ListData[indexPath.row].title
        cell.DesLabel.text = ListData[indexPath.row].descriptions
        let imageUrl = URL(string: ListData[indexPath.row].urlToImage ?? "")
        cell.MainImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Default"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
