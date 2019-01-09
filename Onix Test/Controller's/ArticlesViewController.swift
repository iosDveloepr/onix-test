//
//  ViewController.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/3/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit
import AlamofireImage

enum SegueIdentifiers {
    static let articleDetail = "articleDetailVC"
}

class ArticlesViewController: UIViewController, AlertDisplayer{
    
    var articles = [Article]()
    var article: Article!
    let apiManager = APIManager()
    let articleCell = "articleCell"
  
   @IBOutlet weak var tableView: UITableView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
      
        apiManager.genericFetch(urlString: Endpoint.techcrunch.rawValue) { [unowned self] (articlesResponse: ArticleResponse?, error: APIError?) in
           
            if let error = error{
                switch error{
                case .invalidData: self.onFetchFailed(with: "Invalid data")
                case .jsonParsingFailure: self.onFetchFailed(with: "JSON parsing failure")
                case .requestFailed: self.onFetchFailed(with: "Request failed")
                }
            }
            if let article = articlesResponse?.articles{
                  self.articles = article
                  self.articles.forEach({ $0.liked = false })
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
         }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let secondTab = self.tabBarController?.viewControllers?[1].contentViewcontroller as! FavoriteArticlesViewController
        secondTab.articles = articles.filter( {$0.liked == true} )
    }
    
    private func onFetchFailed(with reason: String) {
        let title = "Warning"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.articleDetail {
            if let articleDetailViewController = segue.destination as? ArticleDetailViewController{
                articleDetailViewController.article = article
            }
        }
    }
    
} // class


extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let article = articles[indexPath.row]
        let cell = Bundle.main.loadNibNamed("ArticlesTableViewCell", owner: self, options: nil)?.first as! ArticlesTableViewCell
        cell.articleTitle.text = article.title
        cell.articleDescription.text = article.description
        if let url = article.urlToImage{
            cell.articleImage.af_setImage(withURL: URL(string: url)!)
        }
        cell.article = article
        
        if article.liked == true{
            cell.articleBtnOutlet.setImage(UIImage(named: "starHeighlited"), for: .normal)
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let currentCell = tableView.cellForRow(at: indexPath)! as! ArticlesTableViewCell
        article = currentCell.article
        performSegue(withIdentifier: SegueIdentifiers.articleDetail, sender: self)
    }
}

