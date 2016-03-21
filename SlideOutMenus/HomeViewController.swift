//
//  HomeViewController.swift
//  SlideOutMenus
//
//  Created by Jagadish Uppala on 3/10/16.
//  Copyright © 2016 Jagadish Uppala. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var slideOutMenuContainerView: UIView!
    @IBOutlet weak var homeCenterContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
        
        homeCenterContainerView.layer.shadowOpacity = 0.5
        homeCenterContainerView.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideOutMenuPressed(sender: AnyObject) {
        if self.homeCenterContainerView.frame.origin.x == 0 {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                self.homeCenterContainerView.frame.origin.x = self.slideOutMenuContainerView.frame.size.width
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                self.homeCenterContainerView.frame.origin.x = 0
                }, completion: nil)
        }
    }

    // MARK: - UIGestureRecognizerDelegate method
    @IBAction func swipedOutMenu(sender: UISwipeGestureRecognizer) {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.homeCenterContainerView.frame.origin.x = self.slideOutMenuContainerView.frame.size.width
            }, completion: nil)
    }
    
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.homeCenterContainerView.frame.origin.x = 0
            }, completion: nil)
//        UIView.animateWithDuration(0.4){
//            self.homeCenterContainerView.frame.origin.x = 0
//            //self.view.layoutIfNeeded()
//        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        if touch.view?.isKindOfClass(UITableViewCell) == true {
//            return true
//        }
//        return false
//    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let hasDraggedRight = (recognizer.velocityInView(view).x > 0)
        print(recognizer.velocityInView(view).x)
        switch(recognizer.state) {
        case .Began:
            break
        case .Changed:
            homeCenterContainerView.frame.origin.x = homeCenterContainerView.frame.origin.x + recognizer.translationInView(view).x
            if hasDraggedRight {
                if homeCenterContainerView.frame.origin.x >= slideOutMenuContainerView.frame.size.width {
                    homeCenterContainerView.frame.origin.x = slideOutMenuContainerView.frame.size.width
                }
            } else {
                if homeCenterContainerView.frame.origin.x <= 0 {
                    homeCenterContainerView.frame.origin.x = 0
                }
            }
            recognizer.setTranslation(CGPointZero, inView: recognizer.view)
        case .Ended:
            let hasSlidedEnough = self.homeCenterContainerView.frame.origin.x > recognizer.view!.center.x / 4
            if hasSlidedEnough && hasDraggedRight {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                    self.homeCenterContainerView.frame.origin.x = self.slideOutMenuContainerView.frame.size.width
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                    self.homeCenterContainerView.frame.origin.x = 0
                    }, completion: nil)
            }
            
        default:
            break
        }
    }

}
