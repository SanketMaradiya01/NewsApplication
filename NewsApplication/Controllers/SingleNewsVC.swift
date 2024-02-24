//
//  SingleNewsVC.swift
//  NewsApplication
//
//  Created by Nimap on 24/02/24.
//

import UIKit
import WebKit

class SingleNewsVC: UIViewController {
    
    var Navbar : UINavigationBar!
    var TitleName : UILabel!
    var NewsImage : UIImageView!
    var AuthorName : UILabel!
    var PublishedAt : UILabel!
    var Title : UILabel!
    var Description : UITextView!
    var DetailedView : UIView!
    var ForMore : UILabel!
    var webView: WKWebView!
    
    var DetailedNewsData : ArticleModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Mode")
        NewsUI()
    }
    
    func NewsUI(){
        
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
        
        let LeftBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(BackButtonTapped))
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = LeftBtn
        Navbar.items = [navigationItem]
        
        
        NewsImage = UIImageView()
        NewsImage.translatesAutoresizingMaskIntoConstraints = false
        let imageUrl = URL(string: DetailedNewsData!.urlToImage ?? "")
        self.NewsImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Logo"))
        view.addSubview(NewsImage)
        NSLayoutConstraint.activate([
            NewsImage.topAnchor.constraint(equalTo: Navbar.bottomAnchor),
            NewsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            NewsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NewsImage.heightAnchor.constraint(equalToConstant: 250.0)
        ])
        
        DetailedView = UIView()
        DetailedView.backgroundColor = .white
        DetailedView.layer.cornerRadius = 25
        DetailedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        DetailedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(DetailedView)
        
        NSLayoutConstraint.activate([
            DetailedView.topAnchor.constraint(equalTo: NewsImage.bottomAnchor, constant: -30.0),
            DetailedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            DetailedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            DetailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        AuthorName = UILabel()
        AuthorName.text = "Author: \(DetailedNewsData?.author ?? "")"
        AuthorName.font = UIFont.boldSystemFont(ofSize: 18.0)
        AuthorName.textColor = .black
        AuthorName.numberOfLines = 0
        AuthorName.translatesAutoresizingMaskIntoConstraints = false
        DetailedView.addSubview(AuthorName)
        
        NSLayoutConstraint.activate([
            AuthorName.topAnchor.constraint(equalTo: DetailedView.topAnchor, constant: 10.0),
            AuthorName.leadingAnchor.constraint(equalTo: DetailedView.leadingAnchor, constant: 10.0),
            AuthorName.trailingAnchor.constraint(equalTo: DetailedView.trailingAnchor, constant: -10.0)
        ])
        
        PublishedAt = UILabel()
        PublishedAt.text = "Published At: \(DetailedNewsData?.publishedAt ?? "")"
        PublishedAt.font = UIFont.boldSystemFont(ofSize: 11.0)
        PublishedAt.textColor = .black
        PublishedAt.numberOfLines = 0
        PublishedAt.translatesAutoresizingMaskIntoConstraints = false
        DetailedView.addSubview(PublishedAt)
        
        NSLayoutConstraint.activate([
            PublishedAt.topAnchor.constraint(equalTo: AuthorName.bottomAnchor, constant: 5.0),
            PublishedAt.leadingAnchor.constraint(equalTo: DetailedView.leadingAnchor, constant: 10.0),
            PublishedAt.trailingAnchor.constraint(equalTo: DetailedView.trailingAnchor, constant: -10.0)
        ])
        
        ForMore = UILabel()
        ForMore.font = UIFont.systemFont(ofSize: 10.0)
        ForMore.textColor = .black
        ForMore.isUserInteractionEnabled = true
        ForMore.numberOfLines = 1
        ForMore.translatesAutoresizingMaskIntoConstraints = false
        DetailedView.addSubview(ForMore)
        
        NSLayoutConstraint.activate([
            ForMore.topAnchor.constraint(equalTo: PublishedAt.bottomAnchor, constant: 5.0),
            ForMore.leadingAnchor.constraint(equalTo: DetailedView.leadingAnchor, constant: 10.0),
            ForMore.trailingAnchor.constraint(equalTo: DetailedView.trailingAnchor, constant: -10.0)
        ])
        let attributedString = NSAttributedString(string: "Click here for more information",
                                                  attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.blue])
        ForMore.attributedText = attributedString
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
                ForMore.addGestureRecognizer(tapGesture)
        
        TitleName = UILabel()
        TitleName.text = "\(DetailedNewsData?.title ?? "")"
        TitleName.font = UIFont.boldSystemFont(ofSize: 18.0)
        TitleName.textColor = .black
        TitleName.numberOfLines = 0
        TitleName.translatesAutoresizingMaskIntoConstraints = false
        DetailedView.addSubview(TitleName)
        
        NSLayoutConstraint.activate([
            TitleName.topAnchor.constraint(equalTo: ForMore.bottomAnchor, constant: 10.0),
            TitleName.leadingAnchor.constraint(equalTo: DetailedView.leadingAnchor, constant: 10.0),
            TitleName.trailingAnchor.constraint(equalTo: DetailedView.trailingAnchor, constant: -10.0)
        ])
        
        Description = UITextView()
        Description.text = DetailedNewsData?.descriptions
        Description.font = UIFont.systemFont(ofSize: 16.0)
        Description.textColor = .black
        Description.isEditable = false
        Description.translatesAutoresizingMaskIntoConstraints = false
        DetailedView.addSubview(Description)
        NSLayoutConstraint.activate([
            Description.topAnchor.constraint(equalTo: TitleName.bottomAnchor, constant: 5.0),
            Description.leadingAnchor.constraint(equalTo: DetailedView.leadingAnchor, constant: 5.0),
            Description.trailingAnchor.constraint(equalTo: DetailedView.trailingAnchor, constant: -5.0),
            Description.bottomAnchor.constraint(equalTo: DetailedView.bottomAnchor, constant: -10.0)
        ])
    }
    @objc func BackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func linkTapped() {
            // Handle the link tap event, for example, open a URL
        if let url = URL(string: DetailedNewsData?.url ?? "") {
                UIApplication.shared.open(url)
            }
        }
}
//    @objc func linkTapped() {
//            guard let urlString = DetailedNewsData?.url, let url = URL(string: urlString) else {
//                return
//            }
//
//            // Open the URL in a WKWebView within a new view controller
//            let webViewController = UIViewController()
//            webViewController.view.backgroundColor = .white
//
//            // Create a WKWebView
//            webView = WKWebView()
//            webView.translatesAutoresizingMaskIntoConstraints = false
//            webViewController.view.addSubview(webView)
//
//            // Create a "Cancel" button
//            let cancelButton = UIButton(type: .system)
//            cancelButton.setTitle("Cancel", for: .normal)
//            cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
//            cancelButton.translatesAutoresizingMaskIntoConstraints = false
//            webViewController.view.addSubview(cancelButton)
//
//            NSLayoutConstraint.activate([
//                webView.topAnchor.constraint(equalTo: webViewController.view.topAnchor),
//                webView.leadingAnchor.constraint(equalTo: webViewController.view.leadingAnchor),
//                webView.trailingAnchor.constraint(equalTo: webViewController.view.trailingAnchor),
//                webView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor),
//
//                cancelButton.leadingAnchor.constraint(equalTo: webViewController.view.leadingAnchor),
//                cancelButton.trailingAnchor.constraint(equalTo: webViewController.view.trailingAnchor),
//                cancelButton.bottomAnchor.constraint(equalTo: webViewController.view.bottomAnchor)
//            ])
//
//            let request = URLRequest(url: url)
//            webView.load(request)
//
//            present(webViewController, animated: true, completion: nil)
//        }
//
//        @objc func cancelButtonTapped() {
//            dismiss(animated: true, completion: nil)
//        }
