//
//  VideoCell.swift
//  Assignment
//
//  Created by Devang Shah on 09/02/22.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgThumbnail.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ video: Items) {
        lblTitle.text = video.snippet.title
        imgThumbnail.downloadImageFrom(link: video.snippet.thumbnails.high.url)
    }
    
}
