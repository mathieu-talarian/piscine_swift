//
//  ViewController.swift
//  D03
//
//  Created by Mathieu MOULLEC on 1/11/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            collection.delegate = self
            collection.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollection", for: indexPath) as! ImagesCollectionViewCell
        let image = Images.allImages[indexPath.row]
        cell.urlString(image, self)
        print(cell.image.description)
        cell.image.stopAnimating()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollection", for: indexPath) as! ImagesCollectionViewCell
        performSegue(withIdentifier: "ImageSegue", sender: cell)
    }
    
}
