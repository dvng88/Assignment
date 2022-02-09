//
//  UIImageView+extensions.swift
//  Assignment
//
//  Created by Devang Shah on 09/02/22.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link: String) {
        URLSession.shared.dataTask( with: URL(string: link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data)
                } else {
                    print("Failed : \(link)")
                }
            }
        }).resume()
    }
}
