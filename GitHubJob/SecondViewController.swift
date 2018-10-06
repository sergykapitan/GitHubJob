//
//  SecondViewController.swift
//  GitHubJob
//
//  Created by Sergey Koriukin on 05.10.2018.
//  Copyright © 2018 Sergey Koriukin. All rights reserved.
//

import Foundation
import UIKit


class SecondViewController: UIViewController {
    var listing: Item!
   
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
    
   
            infoLabel.attributedText =  listing.details.html2Attributed
    
       
    }
}


extension String {
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

