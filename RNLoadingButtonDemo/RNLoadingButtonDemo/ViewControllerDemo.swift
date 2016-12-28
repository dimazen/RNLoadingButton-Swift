//
//  ViewControllerDemo.swift
//  RNButtomWithLoading
//
//  Created by Romilson Nunes on 06/08/14.
//  Copyright (c) 2014 Romilson. All rights reserved.
//

import UIKit

class ViewControllerDemo: UIViewController {
    
    @IBOutlet var btn1:RNLoadingButton!
    @IBOutlet var btn2:RNLoadingButton!
    @IBOutlet weak var customButton: RNLoadingButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark: Buttons From Nib
        // Configure State
        btn1.hideTextWhenLoading = false
        btn1.loading = false
        btn1.activityIndicatorAlignment = RNActivityIndicatorAlignment.right
        btn1.activityIndicatorEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 10)
        btn1.setTitleColor(UIColor(white: 0.673, alpha: 1.0), for: UIControlState.disabled)
        btn1.setTitle("connecting           ", for: UIControlState.disabled)
        
        
        btn2.hideTextWhenLoading = false
        btn2.loading = false
        btn2.activityIndicatorAlignment = RNActivityIndicatorAlignment.left
        btn2.setActivityIndicatorStyle(UIActivityIndicatorViewStyle.gray, state: UIControlState.disabled)
        btn2.activityIndicatorEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        btn2.setTitle("Loading", for: UIControlState.disabled)
        
        let indicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 15),
            type: .ballPulse)
        customButton.setCustomLoadingView(indicatorView, animation: {
            indicatorView.startAnimation()
        }, completion: {
            indicatorView.hidesWhenStopped = true
            indicatorView.stopAnimation()
        })

    }

    
    func randomAttributes(_ button:RNLoadingButton) {
        
        buttonTapAction(button)
        
        let time = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            // your function here
            self.randomAttributes(button)
            })
    }
    
    @IBAction func buttonTapAction(_ button:RNLoadingButton) {
        
        button.loading = !button.loading
        button.activityIndicatorAlignment = RNActivityIndicatorAlignment.center
        button.hideImageWhenLoading = true
        
    }
    
    
    @IBAction func doTap(_ sender:RNLoadingButton) {
        
        sender.isEnabled = false
        sender.loading = true;
        
        if sender.tag == 3 {
            sender.hideImageWhenLoading = true
        }
        
        let time = DispatchTime.now() + Double(Int64(3.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            sender.isEnabled = true
            sender.loading = false
            
            if sender.tag == 3 {
                sender.isSelected = !sender.isSelected
            }
        })
    }


}
