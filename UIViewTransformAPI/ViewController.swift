//
//  ViewController.swift
//  UIViewTransformAPI
//
//  Created by ZhangHS on 16/8/9.
//  Copyright © 2016年 ZhangHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let screenWidth  = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height

    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var combiningBtn: UIButton!
    @IBOutlet weak var scalingBtn: UIButton!
    @IBOutlet weak var rotationBtn: UIButton!
    @IBOutlet weak var translationBtn: UIButton!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var operateView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        headView.hidden          = true
        combiningBtn.center.x -= screenWidth
        scalingBtn.center.x     -= screenWidth
        rotationBtn.center.x    -= screenWidth
        translationBtn.center.x -= screenWidth

        UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.combiningBtn.center.x += self.screenWidth
            }, completion: nil)

        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.scalingBtn.center.x += self.screenWidth
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.rotationBtn.center.x += self.screenWidth
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.translationBtn.center.x += self.screenWidth
            }, completion: nil)
    }

    @IBAction func operating(sender: UIButton) {
        headAnimate(sender.titleLabel?.text, color: sender.backgroundColor)
    }


    func headAnimate(title: String?, color: UIColor?) {
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.headView.center.x += self.screenWidth
            }, completion: { _ in
                self.headView.hidden = true
                self.headView.center.x -= self.screenWidth
                UIView.transitionWithView(self.headView, duration: 0.5, options: .TransitionCurlDown, animations: {
                    self.headView.hidden = false
                    if let headTitle = title {
                        self.headLabel.text = headTitle
                    } else {
                        self.headLabel.text = "请稍候..."
                    }
                    if let titleColor = color {
                        self.headLabel.textColor = titleColor
                    }
                    }, completion: { _ in
                        if let bgColor = color {
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
                                self.operateView.backgroundColor = bgColor
                                }, completion: { _ in
                                    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveLinear, animations: {
                                        switch title! {
                                        case "混合":
                                            let transform1 = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                                            let transform2 = CGAffineTransformMakeTranslation(100, 0)
                                            self.operateView.transform = CGAffineTransformConcat(transform1, transform2)
                                        case "缩放":
                                            self.operateView.transform = CGAffineTransformMakeScale(1.5, 1.5)
                                        case "旋转":
                                            self.operateView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                                        case "平移":
                                            self.operateView.transform = CGAffineTransformMakeTranslation(50, 0)
                                        default:
                                            return
                                        }
                                        }, completion: { _ in
                                            UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveLinear, animations: {
                                                self.operateView.transform = CGAffineTransformIdentity
                                                }, completion: nil)
                                    })
                            })
                        }
                })
        })
    }
}

