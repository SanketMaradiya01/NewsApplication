//
//  ViewController.swift
//  NewsApplication
//
//  Created by Nimap on 22/02/24.
//

import UIKit
import SDWebImage

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}


class ViewController: UIViewController {
    
    var TopView : UIView!
    var TitleLabel: UILabel!
    var tableView : UITableView!
    var collectionView : UICollectionView!
    var activityIndicator: UIActivityIndicatorView!
    
    var NewsData = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AccentColor")
        NewsUI()
        showActivityIndicator()
        NewsAPI()
    }
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    func NewsUI(){
        TopView = UIView()
        TopView.backgroundColor = .clear
        TopView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TopView)
        NSLayoutConstraint.activate([
            TopView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            TopView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            TopView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            TopView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        TitleLabel = UILabel()
        TitleLabel.textColor = .white
        TitleLabel.text = "News App"
        TitleLabel.textAlignment = .center
        TitleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TopView.addSubview(TitleLabel)
        NSLayoutConstraint.activate([
            TitleLabel.topAnchor.constraint(equalTo: TopView.topAnchor),
            TitleLabel.leadingAnchor.constraint(equalTo: TopView.leadingAnchor),
            TitleLabel.trailingAnchor.constraint(equalTo: TopView.trailingAnchor),
            TitleLabel.bottomAnchor.constraint(equalTo: TopView.bottomAnchor)
        ])
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let width = self.view.frame.size.width * 1 - 20
        let height = width / 2.2
        flowLayout.itemSize = CGSize(width: width, height: height) // Set your item size
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(NewsCVC.self, forCellWithReuseIdentifier: "CellIdentifier")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: TopView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 180.0)
        ])
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTVC.self, forCellReuseIdentifier: "CellIdentifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reversedIndex = NewsData.count - 1 - indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! NewsCVC
        cell.titleLabel.text = NewsData[reversedIndex].title
        cell.Description.text = NewsData[reversedIndex].description
        
        if let imageUrl = URL(string: NewsData[reversedIndex].urlToImage ?? "") {
            cell.Image.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Default"))
        } else {
            cell.Image.image = UIImage(named: "Default")
        }
        
        return cell
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! NewsTVC
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        cell.TitleLbl.text = NewsData[indexPath.row].title
        cell.DesLabel.text = NewsData[indexPath.row].description
        let imageUrl = URL(string: NewsData[indexPath.row].urlToImage ?? "")
        cell.MainImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Default"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
extension ViewController {
    func NewsAPI() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2024-01-22&sortBy=publishedAt&apiKey=c81465080c2c409a8509bc6e8c04036e") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                self.hideActivityIndicator()
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(NewsResponse.self, from: data)
                    if let articles = decodedData.articles, decodedData.status == "ok" {
                        self.NewsData = articles
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.collectionView.reloadData()
                            self.hideActivityIndicator()
                        }
                        print(decodedData)
                    } else {
                        print("Invalid data format")
                        self.hideActivityIndicator()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    self.hideActivityIndicator()
                }
            }
        }.resume()
    }
}
