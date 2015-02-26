//
//  CanvasViewController.swift
//  Animaticons
//
//  Created by Hao Sun on 2/25/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var initialTrayYPosition = CGFloat(0)
    var initialDragYPosition = CGFloat(0)
    var trayIsClosed = false
    @IBOutlet weak var arrowImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        trayView.addGestureRecognizer(panGestureRecognizer)
        initialTrayYPosition = trayView.center.y
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            initialDragYPosition = point.y
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            trayView.center.y += (point.y - initialDragYPosition)/100
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if velocity.y < 0 {
                self.openTray(velocity)
            } else {
                self.closeTray(velocity)
            }
        }
    }
    
    func closeTray(_velocity: CGPoint) {
       UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: nil, animations: { () -> Void in
        if !self.trayIsClosed {
            self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, CGFloat(M_PI))
        }
        self.trayView.center.y = self.initialTrayYPosition + 150
       }) { (completed) -> Void in
        self.trayIsClosed = true
       }
    }
    
    func openTray(_velocity: CGPoint) {
       UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: nil, animations: { () -> Void in
        if self.trayIsClosed {
            self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, CGFloat(-M_PI))
        }
        self.trayView.center.y = self.initialTrayYPosition
       }) { (completed) -> Void in
        self.trayIsClosed = false
       }
    }
}
