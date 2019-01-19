//
//  ArticlesTableViewCell.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/4/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleBtnOutlet: UIButton!
    
    var article: Article!
    
    func setUpCell(withArticle article: Article){
        articleTitle.text = article.title
        articleDescription.text = article.description
        if let url = article.urlToImage{
            articleImage.af_setImage(withURL: URL(string: url)!)
        }
        if article.liked == true{
            articleBtnOutlet.setImage(UIImage(named: "starHeighlited"), for: .normal)
        }
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
       
        if article.liked == true{
            article.liked = false
            articleBtnOutlet.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        } else {
            article.liked = true
            articleBtnOutlet.setImage(#imageLiteral(resourceName: "starHeighlited"), for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        articleImage.af_cancelImageRequest()
        articleImage.image = nil
    }
    
} // class
