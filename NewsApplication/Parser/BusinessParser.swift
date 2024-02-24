//
//  BusinessParser.swift
//  NewsApplication
//
//  Created by Nimap on 24/02/24.
//

import UIKit

protocol APICallingParserDelegate : NSObjectProtocol {
    func MyAPICalling(ApicallArray : [ArticleModel])
}

class BusinessParser: NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
    
    var data : Data?
    var delegate : APICallingParserDelegate?
    
    var session : URLSession{
        let congifration = URLSessionConfiguration.default
        congifration.requestCachePolicy = NSURLRequest.CachePolicy.reloadRevalidatingCacheData
        let sessions = URLSession(configuration: congifration, delegate: self, delegateQueue: nil)
        
        return sessions
    }
    func getUserData(){
        let url = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2024-02-22&to=2024-02-22&sortBy=popularity&apiKey=c81465080c2c409a8509bc6e8c04036e")
        let task = session.downloadTask(with: url!)
        task.resume()
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            do{
                data = try Data(contentsOf: location)
                
                let responseString = String(data: data!, encoding: String.Encoding.utf8)
//                print("responseString \(responseString!)")
                
                let jsonConvert = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                var models : [ArticleModel] = []
                
                if jsonConvert!["status"] as! String == "ok" {
                    let result = jsonConvert!["articles"] as! [[String : Any]]
                    for i in 0..<result.count {
                        let model = ArticleModel(dictionary: result[i])
                        models.append(model)
                    }
                    DispatchQueue.main.async {
                        if self.delegate != nil {
                            self.delegate!.MyAPICalling(ApicallArray: models)
                        }
                    }
                }else{
                    print("Something Went Wrong")
                }
              
                
                
                
            }catch{
                print("Error")
            }
        }}
