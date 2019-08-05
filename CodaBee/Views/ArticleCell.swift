//
//  ArticleCell.swift
//  CodaBee
//
//  Created by Bernard Masset on 24/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleIV: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    var article: Article!
    
    func setup(_ article: Article) {
        self.article = article
        setup()
        titleLbl.text = self.article.title
        // Date à formater
        dateLbl.text = self.article.pubDate.IlYa()
        //print(self.article.pubDate)
        articleIV.download(string: self.article.imageUrl)
    }
}
