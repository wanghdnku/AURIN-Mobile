//
//  WalkthroughPageViewController.swift
//  AURIN Mobile
//
//  Created by Hayden on 16/4/19.
//  Copyright © 2016年 University of Melbourne. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var stop = false
    
    var pageImages = ["walkthrough_0", "walkthrough_1", "walkthrough_2", "walkthrough_3", "walkthrough_4", "walkthrough_5", "walkthrough_6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the data source to itself
        dataSource = self
        // Create the first walkthrough screen
        if let startingViewController = viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
        
    }
    
    
    

    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if stop {
            return nil
        }
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        if index == 7 {
            stop = true
            return animationViewController(index)
        } else {
            return viewControllerAtIndex(index)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if stop {
            return nil
        }
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func animationViewController(index: Int) -> WalkthroughAnimationViewController? {
        if let animationContentViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughAnimationViewController") as? WalkthroughAnimationViewController {
            //animationContentViewController.index = index
            return animationContentViewController
        }
        return nil
    }
    
    
    func viewControllerAtIndex(index: Int) -> WalkthroughContentViewController? {
        if index == NSNotFound || index < 0 || index >= pageImages.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContentViewController") as? WalkthroughContentViewController {
            stop = false
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }
    
    func forward(index:Int) {
        if let nextViewController = viewControllerAtIndex(index + 1) {
            setViewControllers([nextViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
