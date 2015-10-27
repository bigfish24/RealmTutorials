//
//  MainGridController.swift
//  GridViewExample
//
//  Created by Adam Fish on 10/26/15.
//  Copyright © 2015 Adam Fish. All rights reserved.
//

import UIKit
import RealmSwiftNYTStories
import RealmGridController
import RealmSwift
import Haneke
import TOWebViewController

private let reuseIdentifier = "mainCell"

class MainGridController: RealmGridController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the Realm object class name that the grid controller will bind to
        self.entityName = "NYTStory"
        
        // Sort the article in reverse chronological order
        self.sortDescriptors = [SortDescriptor(property: "publishedDate", ascending: false)]
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainCollectionViewCell
    
        // Configure the cell
        let aStory = self.objectAtIndexPath(NYTStory.self, indexPath: indexPath)
        
        cell.titleLabel.text = aStory?.title
        cell.excerptLabel.text = aStory?.abstract
        
        if let date = aStory?.publishedDate {
            cell.dateLabel.text = NYTStory.stringFromDate(date)
        }
        
        // Lazy load image using Haneke library
        if let imageURL = aStory?.storyImage?.url {
            cell.imageView.hnk_setImageFromURL(imageURL)
        }
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        let story = self.objectAtIndexPath(NYTStory.self, indexPath: indexPath)
        
        if let urlString = story?.urlString {
            let webController = TOWebViewController(URLString: urlString)
            
            let navController = UINavigationController(rootViewController: webController)
            
            self.navigationController?.presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height: CGFloat = 250.0
        
        if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.Portrait {
            let columns: CGFloat = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad ? 3.0 : 2.0
            
            let width = CGRectGetWidth(self.view.frame) / columns
            
            return CGSizeMake(width, height)
        }
        else {
            let columns: CGFloat = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad ? 4.0 : 3.0
            
            let width = CGRectGetWidth(self.view.frame) / columns
            
            return CGSizeMake(width, height)
        }
    }

    @IBAction func didClickRefreshButton(sender: UIBarButtonItem) {
        NYTStory.loadLatestStories(intoRealm: try! Realm(), withAPIKey: "INSERT_YOUR_API_KEY_HERE");
    }
}
