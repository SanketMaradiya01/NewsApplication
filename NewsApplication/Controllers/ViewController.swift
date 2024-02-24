//
//  ViewController.swift
//  NewsApplication
//
//  Created by Nimap on 22/02/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, APICallingParserDelegate,TechAPICallingParserDelegate,TeslaAPICallingParserDelegate {
    
    var appdelegate: UIWindow?
    //    appdelegate = UIApplication.shared.windows.first
    
    let defaults = UserDefaults.standard
    
    var TopView : UIView!
    var Logo: UIImageView!
    var ListView : UIView!
    var ListTitle: UILabel!
    var tableView : UITableView!
    var collectionView : UICollectionView!
    var CategoriesCV : UICollectionView!
    var activityIndicator: UIActivityIndicatorView!
    
    var timer: Timer?
    var currentIndex = 0
    var shouldStopTimer = false
    var selectedCategoryIndex: Int?
    
    var apiParser : BusinessParser?
    var TechapiParser : TechParser?
    var TeslaapiParser : TeslaParser?
    
    var NewsData : [ArticleModel] = []
    var TeslaData : [ArticleModel] = []
    var TechData : [ArticleModel] = []
    
    
    
    var CatData = ["Tesla","business","TechCrunch"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Mode")
        NewsUI()
        showActivityIndicator()
        loadParser()
        startTimer()
    }
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    func MyAPICalling(ApicallArray: [ArticleModel]) {
        NewsData = ApicallArray
        tableView.reloadData()
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        
    }
    func MyTechAPICalling(ApicallArray: [ArticleModel]) {
        TechData = ApicallArray
        tableView.reloadData()
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func MyTeslaAPICalling(ApicallArray: [ArticleModel]) {
        TeslaData = ApicallArray
        tableView.reloadData()
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func loadParser() {
        apiParser = BusinessParser()
        apiParser?.delegate = self
        apiParser?.getUserData()
    }
    func TechloadParser() {
        TechapiParser = TechParser()
        TechapiParser?.delegate = self
        TechapiParser?.getUserData()
    }
    func TeslaloadParser() {
        TeslaapiParser = TeslaParser()
        TeslaapiParser?.delegate = self
        TeslaapiParser?.getUserData()
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
        Logo = UIImageView()
        Logo.image = UIImage(named: "Logo")
        Logo.translatesAutoresizingMaskIntoConstraints = false
        TopView.addSubview(Logo)
        NSLayoutConstraint.activate([
            Logo.centerXAnchor.constraint(equalTo: TopView.centerXAnchor),
            Logo.centerYAnchor.constraint(equalTo: TopView.centerYAnchor)
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
            collectionView.topAnchor.constraint(equalTo: TopView.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 180.0)
        ])
        
        ListView = UIView()
        ListView.backgroundColor = .clear
        ListView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ListView)
        NSLayoutConstraint.activate([
            ListView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            ListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ListView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        let CategoriesFL = UICollectionViewFlowLayout()
        CategoriesFL.scrollDirection = .horizontal
        let Width = 100
        let Height = 40
        CategoriesFL.itemSize = CGSize(width: Width, height: Height) // Corrected item size
        CategoriesFL.minimumLineSpacing = 10
        CategoriesFL.minimumInteritemSpacing = 10
        CategoriesFL.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        CategoriesCV = UICollectionView(frame: view.bounds, collectionViewLayout: CategoriesFL)
        CategoriesCV.backgroundColor = .clear
        CategoriesCV.register(MoreNews.self, forCellWithReuseIdentifier: "MoreCellIdentifier")
        CategoriesCV.delegate = self
        CategoriesCV.dataSource = self
        CategoriesCV.translatesAutoresizingMaskIntoConstraints = false
        ListView.addSubview(CategoriesCV)
        NSLayoutConstraint.activate([
            CategoriesCV.topAnchor.constraint(equalTo: ListView.topAnchor),
            CategoriesCV.leadingAnchor.constraint(equalTo: ListView.leadingAnchor),
            CategoriesCV.trailingAnchor.constraint(equalTo: ListView.trailingAnchor),
            CategoriesCV.bottomAnchor.constraint(equalTo: ListView.bottomAnchor)
        ])
        
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTVC.self, forCellReuseIdentifier: "CellIdentifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: ListView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    @objc func buttonTapped() {
        let otherViewController = AllNewsViewController()
        otherViewController.ListData = NewsData
        navigationController?.pushViewController(otherViewController, animated: true)
        print("Button tapped!")
    }
}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            // Return the number of items for the main collectionView
            return min(10, NewsData.count)
        } else if collectionView == CategoriesCV {
            // Return the number of items for the CategoriesCV
            return CatData.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! NewsCVC
            let reversedIndex = NewsData.count - 1 - indexPath.row
            cell.titleLabel.text = NewsData[reversedIndex].title
            cell.Description.text = NewsData[reversedIndex].descriptions
            if let imageUrl = URL(string: NewsData[reversedIndex].urlToImage ?? "") {
                cell.Image.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Logo"))
            } else {
                cell.Image.image = UIImage(named: "Default")
            }
            return cell
        } else if collectionView == CategoriesCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCellIdentifier", for: indexPath) as! MoreNews
            if let selectedCategoryIndex = selectedCategoryIndex, indexPath.row == selectedCategoryIndex {
                cell.layer.borderWidth = 1.0
                cell.layer.borderColor = UIColor.white.cgColor
            } else {
                cell.layer.borderWidth = 0.0
            }
            cell.moreLabel.text = CatData[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == CategoriesCV {
            selectedCategoryIndex = indexPath.row
            CategoriesCV.reloadData()
            let selectedCategory = CatData[indexPath.row]
            activityIndicator.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                var newData: [ArticleModel] = []
                switch selectedCategory {
                case "Tesla":
                    self.TeslaloadParser()
                    newData = self.TeslaData
                case "business":
                    self.loadParser()
                    newData = self.NewsData
                case "TechCrunch":
                    self.TechloadParser()
                    newData = self.TechData
                default:
                    break
                }
                DispatchQueue.main.async {
                    self.updateDataAndReloadViews(data: newData)
                    self.activityIndicator.stopAnimating()
                }
            }
        } else if collectionView == collectionView{
            let DetailedNewsVC = SingleNewsVC()
            let reversedIndex = NewsData.count - 1 - indexPath.row
            DetailedNewsVC.DetailedNewsData = NewsData[reversedIndex]
            self.navigationController?.pushViewController(DetailedNewsVC, animated: true)
        }
    }
    private func updateDataAndReloadViews(data: [ArticleModel]) {
        NewsData = data
        tableView.reloadData()
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
}

//TableView

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! NewsTVC
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        cell.selectionStyle = .none
        cell.TitleLbl.text = NewsData[indexPath.row].title
        cell.DesLabel.text = NewsData[indexPath.row].descriptions
        let imageUrl = URL(string: NewsData[indexPath.row].urlToImage ?? "")
        cell.MainImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Logo"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailedVC = SingleNewsVC()
        DetailedVC.DetailedNewsData = NewsData[indexPath.row]
        self.navigationController?.pushViewController(DetailedVC, animated: true)
    }
}
//Timer
extension ViewController {
    func startTimer() {
        shouldStopTimer = false
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateCollectionView), userInfo: nil, repeats: true)
    }
    
    @objc func updateCollectionView() {
        guard NewsData.count > 0 else {
            return
        }
        
        currentIndex += 1
        
        if currentIndex >= NewsData.count {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        
        // Check if the index path is valid
        guard indexPath.item < collectionView.numberOfItems(inSection: 0) else {
            shouldStopTimer = true
            stopTimer()
            return
        }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
