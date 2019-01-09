//
//  ArticleDetailViewController.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/4/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articledescription: UITextView!
    @IBOutlet weak var likeBtnOutlet: UIButton!
    
    var article: Article!

    override func viewDidLoad() {
        super.viewDidLoad()

        articleTitle.text = article.title
        articledescription.text = article.description
        
        if let url = article.urlToImage{
            let urlToImage = URL(string: url)!
            articleImageView.af_setImage(withURL: urlToImage)
        }
        
        article.liked! == true ? likeBtnOutlet.setImage(UIImage(named: "starHeighlited"), for: .normal) : likeBtnOutlet.setImage(UIImage(named: "star"), for: .normal)
    }
    
    
    @IBAction func likeButton(_ sender: UIButton) {
        if article.liked == true{
            article.liked = false
            likeBtnOutlet.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        } else {
            article.liked = true
            likeBtnOutlet.setImage(#imageLiteral(resourceName: "starHeighlited"), for: .normal)
        }
    }
    
    
    deinit {
        print("ArticleDetailViewController was deinit")
    }
 

} // class
