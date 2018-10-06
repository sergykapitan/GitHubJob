//
//  Ex.swift
//  GitHubJob
//
//  Created by Sergey Koriukin on 05.10.2018.
//  Copyright © 2018 Sergey Koriukin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

 

extension UIImageView {
    
    func downloadedFrom(link:String) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard let data = data , error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        }).resume()
    }
    
}
