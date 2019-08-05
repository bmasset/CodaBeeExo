//
//  VideoCell.swift
//  CodaBee
//
//  Created by Bernard Masset on 27/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit
import SDWebImage

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    var video: Video!
    
    func setup(_ video: Video) {
        self.video = video
        setup()
        titleLbl.text = self.video.snippet.title
        thumb.sd_setImage(with: URL(string: self.video.snippet.thumbnails.high.url), placeholderImage: BUMBLE_IMAGE, options: SDWebImageOptions.highPriority, completed: nil)
    }
    
    
}
