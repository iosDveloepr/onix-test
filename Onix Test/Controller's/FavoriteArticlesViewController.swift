//
//  FavoriteArticlesViewController.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/6/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit

class FavoriteArticlesViewController: UIViewController {
    
    var articles = [Article]()
    var article: Article!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.articleDetail {
            if let articleDetailViewController = segue.destination as? ArticleDetailViewController{
                articleDetailViewController.article = article
            }
        }
    }
    
} // class

extension FavoriteArticlesViewController: UITableViewDelegate, UITableViewDataSource{
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
    
} // extension


