//
//  PlayViewController.swift
//  Assignment
//
//  Created by Devang Shah on 09/02/22.
//

import UIKit
import WebKit

class PlayViewController: UIViewController {
    var video: Items!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        guard let id = video.id, let videoId = id.videoId else {
            self.showAlert("Video ID not found")
            return
        }
        let videoURL = "https://www.youtube.com/watch?v=\(videoId)"
        
        guard let url = URL(string: videoURL) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
