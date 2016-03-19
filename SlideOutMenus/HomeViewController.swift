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
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        view.addGestureRecognizer(panGestureRecognizer)
        homeCenterContainerView.layer.shadowOpacity = 0.4
        
        homeCenterContainerView.layer.shadowOffset = CGSize(width: -3.0, height: -5.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slideOutMenuPressed(sender: AnyObject) {
        if self.homeCenterContainerView.frame.origin.x == 0 {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                self.homeCenterContainerView.frame.origin.x = self.slideOutMenuContainerView.frame.size.width * 0.8
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                self.homeCenterContainerView.frame.origin.x = 0
                }, completion: nil)
        }
    }

    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.homeCenterContainerView.frame.origin.x = 0
            }, completion: nil)
        
        //        UIView.animateWithDuration(0.4){
        //            self.homeCenterContainerView.frame.origin.x = 0
        //            //self.view.layoutIfNeeded()
        //        }
    }
    
    // UIGestureRecognizerDelegate method
    
    //    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //        return false
    //    }
    
    //    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    //        if touch.view?.isKindOfClass(UITableViewCell) == true {
    //            return true
    //        }
    //        return false
    //    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let draggedLeftToRight = (recognizer.velocityInView(view).x > 0)
        print(recognizer.velocityInView(view).x)
        switch(recognizer.state) {
        case .Began:
            break
        case .Changed:
            if draggedLeftToRight {
                if homeCenterContainerView.frame.origin.x >= slideOutMenuContainerView.frame.size.width * 0.8 {
                    homeCenterContainerView.frame.origin.x = slideOutMenuContainerView.frame.size.width * 0.8
                } else {
                    homeCenterContainerView.frame.origin.x = homeCenterContainerView.frame.origin.x + recognizer.translationInView(view).x
                }
            } else {
                if homeCenterContainerView.frame.origin.x <= 0 {
                    homeCenterContainerView.frame.origin.x = 0
                } else {
                    homeCenterContainerView.frame.origin.x = homeCenterContainerView.frame.origin.x + recognizer.translationInView(view).x
                }
            }
            recognizer.setTranslation(CGPointZero, inView: recognizer.view)
        case .Ended:
            let hasMovedGreaterThanHalfway = self.homeCenterContainerView.frame.origin.x > recognizer.view!.center.x / 4
            if hasMovedGreaterThanHalfway && draggedLeftToRight {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                    self.homeCenterContainerView.frame.origin.x = self.slideOutMenuContainerView.frame.size.width * 0.8
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                    self.homeCenterContainerView.frame.origin.x = 0
                    }, completion: nil)
            }
            
        default:
            break
        }
    }

}
