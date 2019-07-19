//
//  ImageDowloadController.swift
//  ios-challenge
//
//  Created by Nolan Fuchs on 7/18/19.
//  Copyright © 2019 Owlet Baby Care Inc. All rights reserved.
//

import UIKit

// Image Cache
let imageCache = NSCache<AnyObject, AnyObject>()

class ImageDowloadController: UIViewController {
    
    
    private let norwayImage: String = "https://iphoneswallpapers.com/wp-content/uploads/2017/03/mountain-Lofoten-Norway-sky-sea-lofoten-islands-iPhone-Wallpaper-iphoneswallpapers_com.jpg"
    
    // Activity Indicator
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    // View that will display downloaded image
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImage(urlName: norwayImage)

    }
    
    
    func downloadImage(urlName: String) {
        activity.isHidden = false
        activity.startAnimating()
        guard let imageURL = URL(string: urlName) else { return }
        
        // Checking to see if URL has been previously cached
        if let imageFromCache = imageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            self.imageView.image = imageFromCache
            activity.stopAnimating()
            return
        }
        
        
        // If cache is nil, we retrive data from the sepcified URL
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
        
        DispatchQueue.main.async {
            guard let imageToCache = UIImage(data: data!) else {
                self.activity.stopAnimating()
                self.addErrorLabel()
                return
            }
            
            imageCache.setObject(imageToCache, forKey: imageURL as AnyObject)
            self.imageView.image = imageToCache
            self.activity.stopAnimating()
            }
        }
    }
  
    // If an image is not found, this view will be added, replacing the imageView.
    func addErrorLabel() {
        
        let label = UILabel(frame: self.view.frame)
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        label.text = "No Image Found :("
        label.textColor = .black
        label.textAlignment = .center
        
        self.view.addSubview(label)
    
    }

}
