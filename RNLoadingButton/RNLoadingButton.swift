//
//  RNLoadingButton.swift
//  RNLoadingButton
//
//  Created by Romilson Nunes on 06/06/14.
//  Copyright (c) 2014 Romilson Nunes. All rights reserved.
//

import UIKit
public enum RNActivityIndicatorAlignment: Int {
    case left
    case center
    case right
    
    static func Random() ->RNActivityIndicatorAlignment {
        let max = UInt32(RNActivityIndicatorAlignment.right.rawValue)
        let randomValue = Int(arc4random_uniform(max + 1))
        return RNActivityIndicatorAlignment(rawValue: randomValue)!
    }
}


open class RNLoadingButton: UIButton {
    
    /** Loading */
    open var loading:Bool = false {
        didSet {
            configureControlState(currentControlState());
        }
    }

    open var hideImageWhenLoading:Bool = true {
        didSet {
            configureControlState(currentControlState());
        }
    }
    open var hideTextWhenLoading:Bool = true {
        didSet {
            configureControlState(currentControlState());
        }
    }
    
    open var activityIndicatorEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
    
    /** Loading Alingment */
    open var activityIndicatorAlignment:RNActivityIndicatorAlignment = RNActivityIndicatorAlignment.center {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    open let activityIndicatorView:UIActivityIndicatorView! = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var customIndicatorView: UIView?
    var customLoadingAnimation: (()->Void)?
    var customLoadingCompletion: (()->Void)?
    
    // Internal properties
    let imagens:NSMutableDictionary! = NSMutableDictionary()
    let texts:NSMutableDictionary! = NSMutableDictionary()
    let indicatorStyles : NSMutableDictionary! = NSMutableDictionary()
    
    // Static
    let defaultActivityStyle = UIActivityIndicatorViewStyle.gray

    
    // MARK: - Initializers
    
    deinit {
        self.removeObserver(forKeyPath: "self.state")
        self.removeObserver(forKeyPath: "self.selected")
        self.removeObserver(forKeyPath: "self.highlighted")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.setupActivityIndicator()
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        setupActivityIndicator()
        
        // Images - Icons
        if (super.image(for: UIControlState()) != nil) {
            self.storeValue(super.image(for: UIControlState()), onDic: imagens, state: UIControlState())
        }
        if (super.image(for: UIControlState.highlighted) != nil) {
            self.storeValue(super.image(for: UIControlState.highlighted), onDic: imagens, state: UIControlState.highlighted)
        }
        if (super.image(for: UIControlState.disabled) != nil) {
            self.storeValue(super.image(for: UIControlState.disabled), onDic: imagens, state: UIControlState.disabled)
        }
        if (super.image(for: UIControlState.selected) != nil) {
            self.storeValue(super.image(for: UIControlState.selected), onDic: imagens, state: UIControlState.selected)
        }
        
        // Title - Texts
        if let titleNormal = super.title(for: UIControlState()) {
            self.storeValue(titleNormal as AnyObject?, onDic: texts, state: UIControlState())
        }
        if let titleHighlighted = super.title(for: .highlighted) {
            self.storeValue(titleHighlighted as AnyObject?, onDic: texts, state: .highlighted)
        }
        if let titleDisabled = super.title(for: .disabled) {
            self.storeValue(titleDisabled as AnyObject?, onDic: texts, state: .disabled)
        }
        if let titleSelected = super.title(for: .selected) {
            self.storeValue(titleSelected as AnyObject?, onDic: texts, state: .selected)
        }
        
    }
    
    fileprivate func commonInit() {
        
        self.adjustsImageWhenHighlighted = true
        
        /** Title for States */
        self.texts.setValue(super.title(for: UIControlState()), forKey: "\(UIControlState().rawValue)")
        self.texts.setValue(super.title(for: UIControlState.highlighted), forKey: "\(UIControlState.highlighted.rawValue)")
        self.texts.setValue(super.title(for: UIControlState.disabled), forKey: "\(UIControlState.disabled.rawValue)")
        self.texts.setValue(super.title(for: UIControlState.selected), forKey: "\(UIControlState.selected.rawValue)")
        
        /** Images for States */
        self.imagens.setValue(super.image(for: UIControlState()), forKey: "\(UIControlState().rawValue)")
        self.imagens.setValue(super.image(for: UIControlState.highlighted), forKey: "\(UIControlState.highlighted.rawValue)")
        self.imagens.setValue(super.image(for: UIControlState.disabled), forKey: "\(UIControlState.disabled.rawValue)")
        self.imagens.setValue(super.image(for: UIControlState.selected), forKey: "\(UIControlState.selected.rawValue)")
        
        /** Indicator Styles for States */
        let s:NSNumber = NSNumber(value: defaultActivityStyle.rawValue as Int)
        self.indicatorStyles.setValue(s, forKey: "\(UIControlState().rawValue)")
        self.indicatorStyles.setValue(s, forKey: "\(UIControlState.highlighted.rawValue)")
        self.indicatorStyles.setValue(s, forKey: "\(UIControlState.disabled.rawValue)")
        self.indicatorStyles.setValue(s, forKey: "\(UIControlState.selected.rawValue)")
        
        self.addObserver(forKeyPath: "self.state")
        self.addObserver(forKeyPath: "self.selected")
        self.addObserver(forKeyPath: "self.highlighted")
    }
    
    
    // MARK: - Relayout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let indicator = customIndicatorView {
            indicator.frame = frameForCustomIndicator()
            bringSubview(toFront: indicator)
        } else {
            let style = self.activityIndicatorStyleForState(self.currentControlState())
            self.activityIndicatorView.activityIndicatorViewStyle = style
            self.activityIndicatorView.frame = self.frameForActivityIndicator()
            self.bringSubview(toFront: self.activityIndicatorView)
        }
        
    }
    
    // MARK: - Public Methods
    
    open func setCustomLoadingView(_ view: UIView, animation: @escaping (()->Void), completion: @escaping (()->Void)) {
        customIndicatorView = view
        customLoadingAnimation = animation
        customLoadingCompletion = completion
        setupActivityIndicator()
    }
    
    open func setActivityIndicatorStyle( _ style:UIActivityIndicatorViewStyle, state:UIControlState) {
        let s:NSNumber = NSNumber(value: style.rawValue as Int);
        setControlState( s, dic: indicatorStyles, state: state)
        self.setNeedsLayout()
    }
    
    // Activity Indicator Alignment
    open func setActivityIndicatorAlignment(_ alignment: RNActivityIndicatorAlignment) {
        activityIndicatorAlignment = alignment;
        self.setNeedsLayout();
    }
    
    open func activityIndicatorStyleForState(_ state: UIControlState) -> UIActivityIndicatorViewStyle {
        var style:UIActivityIndicatorViewStyle  = defaultActivityStyle
        if let styleObj: AnyObject = self.getValueForControlState(self.indicatorStyles, state: state)
        {
            // https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/Enumerations.html
            style = UIActivityIndicatorViewStyle(rawValue: (styleObj as! NSNumber).intValue)!
        }
        return style
    }
    
    
    // MARK: - Targets/Actions
    
    func activityIndicatorTapped(_ sender:AnyObject) {
        self.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    // MARK: - Internal Methods
    
    func setupActivityIndicator() {
        if let indicator = customIndicatorView {
            activityIndicatorView.removeFromSuperview() // remove default indicator
            self.addSubview(indicator)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(RNLoadingButton.activityIndicatorTapped(_:)))
            indicator.addGestureRecognizer(tap)
        } else {
            self.activityIndicatorView.hidesWhenStopped = true
            self.activityIndicatorView.startAnimating()
            self.addSubview(self.activityIndicatorView)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(RNLoadingButton.activityIndicatorTapped(_:)))
            self.activityIndicatorView.addGestureRecognizer(tap)
        }
        
    }
    
    func currentControlState() -> UIControlState {
        var controlState = UIControlState().rawValue
        if self.isSelected {
            controlState += UIControlState.selected.rawValue
        }
        if self.isHighlighted {
            controlState += UIControlState.highlighted.rawValue
        }
        if !self.isEnabled {
            controlState += UIControlState.disabled.rawValue
        }
        return UIControlState(rawValue: controlState)
    }
    
    func setControlState(_ value:AnyObject ,dic:NSMutableDictionary, state:UIControlState) {
        dic["\(state.rawValue)"] = value
        configureControlState(currentControlState())
    }
    
    func setImage(_ image:UIImage, state:UIControlState) {
        setControlState(image, dic: self.imagens, state: state)
    }
    

    // MARK: - Override Setters & Getters
   
    override open func setTitle(_ title: String!, for state: UIControlState) {
        self.storeValue(title as AnyObject?, onDic: self.texts, state: state)
        if super.title(for: state) != title {
            super.setTitle(title, for: state)
        }
        self.setNeedsLayout()
    }
    
    override open func title(for state: UIControlState) -> String?  {
        return self.getValueForControlState(self.texts, state: state) as? String
    }
    
    override open func setImage(_ image: UIImage!, for state: UIControlState) {
        self.storeValue(image, onDic: self.imagens, state: state)
        if super.image(for: state) != image {
            super.setImage(image, for: state)
        }
        self.setNeedsLayout()
    }
    
    override open func image(for state: UIControlState) -> UIImage? {
        return self.getValueForControlState(self.imagens, state: state) as? UIImage
    }
    
    
    // MARK: -  Private Methods
    
    fileprivate func addObserver(forKeyPath keyPath:String) {
        self.addObserver(self, forKeyPath:keyPath, options: ([NSKeyValueObservingOptions.initial, NSKeyValueObservingOptions.new]), context: nil)
    }
    
    fileprivate func removeObserver(forKeyPath keyPath: String!) {
        self.removeObserver(self, forKeyPath: keyPath)
    }
    
    fileprivate func getValueForControlState(_ dic:NSMutableDictionary!, state:UIControlState) -> AnyObject? {
        let value:AnyObject? =  dic.value(forKey: "\(state.rawValue)") as AnyObject?;//  dic["\(state)"];
        if (value != nil) {
            return value;
        }
        //        value = dic["\(UIControlState.Selected.rawValue)"];
        //        if ( (state & UIControlState.Selected) && value) {
        //            return value;
        //        }
        //
        //        value = dic["\(UIControlState.Highlighted.rawValue)"];
        //
        //        if ( (state & UIControlState.Selected) && value != nil) {
        //            return value;
        //        }
        
        return dic.value(forKey: "\(UIControlState().rawValue)") as AnyObject;
    }
    
    
    fileprivate func configureControlState(_ state:UIControlState) {
        if self.loading {
            if let _ = customIndicatorView {
                customLoadingAnimation!()
            } else {
                self.activityIndicatorView.startAnimating();
            }
            
            if self.hideImageWhenLoading {
                
                var imgTmp:UIImage? = nil
                
                if let img = self.image(for: UIControlState()) {
                    imgTmp = self.clearImage(img.size, scale: img.scale)
                }
                
                super.setImage(imgTmp, for: UIControlState())
                super.setImage(imgTmp, for: UIControlState.selected)
                
                super.setImage(imgTmp, for: state)
                super.imageView?.image = imgTmp
                
            }
            else {
                super.setImage( self.image(for: state), for: state)
            }
            
            if (self.hideTextWhenLoading) {
                super.setTitle(nil, for: state)
                super.titleLabel?.text = nil
            }
            else {
                super.setTitle( self.title(for: state) , for: state)
                super.titleLabel?.text = self.title(for: state)
            }
        }
        else {
            if let _ = customIndicatorView {
                customLoadingCompletion!()
            } else {
                self.activityIndicatorView.stopAnimating()
            }
            super.setImage(self.image(for: state), for: state)
            super.imageView?.image = self.image(for: state)
            super.setTitle(self.title(for: state), for: state)
            super.titleLabel?.text = self.title(for: state)
        }
        
        self.setNeedsLayout()
    }
    
    fileprivate func frameForCustomIndicator() -> CGRect {
        guard let indicator = customIndicatorView else {
            return CGRect.zero
        }
        
        var frame:CGRect = CGRect.zero;
        frame.size = indicator.frame.size;
        frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
        
        switch self.activityIndicatorAlignment {
            
        case RNActivityIndicatorAlignment.left:
            // top,  left bottom right
            frame.origin.x += self.activityIndicatorEdgeInsets.left;
            frame.origin.y += self.activityIndicatorEdgeInsets.top;
            
        case RNActivityIndicatorAlignment.center:
            frame.origin.x = (self.frame.size.width - frame.size.width) / 2;
            
        case RNActivityIndicatorAlignment.right:
            var lengthOccupied:CFloat = 0;
            var x:CFloat = 0;
            let imageView:UIImageView = self.imageView!;
            let titleLabel:UILabel = self.titleLabel!;
            
            //let xa = CGFloat(UInt(arc4random_uniform(UInt32(UInt(imageView.frame.size.width) * 5))))// - self.gameView.bounds.size.width * 2
            
            if (imageView.image != nil && titleLabel.text != nil){
                lengthOccupied = Float( imageView.frame.size.width + titleLabel.frame.size.width );
                
                
                if (imageView.frame.origin.x > titleLabel.frame.origin.x){
                    lengthOccupied += Float( imageView.frame.origin.x )
                }
                else {
                    lengthOccupied += Float( titleLabel.frame.origin.x )
                }
            }
            else if (imageView.image != nil){
                lengthOccupied = Float( imageView.frame.size.width + imageView.frame.origin.x )
            }
            else if (titleLabel.text != nil){
                lengthOccupied = Float( titleLabel.frame.size.width + imageView.frame.origin.x )
            }
            
            x =  Float(lengthOccupied) + Float( self.activityIndicatorEdgeInsets.left )
            if ( Float(x) + Float(frame.size.width) > Float(self.frame.size.width) ){
                x = Float(self.frame.size.width) - Float(frame.size.width + self.activityIndicatorEdgeInsets.right);
            }
            else if ( Float(x + Float(frame.size.width) ) > Float(self.frame.size.width - self.activityIndicatorEdgeInsets.right)){
                x = Float(self.frame.size.width) - ( Float(frame.size.width) + Float(self.activityIndicatorEdgeInsets.right) );
            }
            
            frame.origin.x = CGFloat(x);
        }
        
        return frame;
    }
    
    fileprivate func frameForActivityIndicator() -> CGRect {
        
        var frame:CGRect = CGRect.zero;
        frame.size = self.activityIndicatorView.frame.size;
        frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
        
        switch self.activityIndicatorAlignment {
            
        case RNActivityIndicatorAlignment.left:
            // top,  left bottom right
            frame.origin.x += self.activityIndicatorEdgeInsets.left;
            frame.origin.y += self.activityIndicatorEdgeInsets.top;
        
        case RNActivityIndicatorAlignment.center:
            frame.origin.x = (self.frame.size.width - frame.size.width) / 2;
       
        case RNActivityIndicatorAlignment.right:
            var lengthOccupied:CFloat = 0;
            var x:CFloat = 0;
            let imageView:UIImageView = self.imageView!;
            let titleLabel:UILabel = self.titleLabel!;
            
            //let xa = CGFloat(UInt(arc4random_uniform(UInt32(UInt(imageView.frame.size.width) * 5))))// - self.gameView.bounds.size.width * 2
            
            if (imageView.image != nil && titleLabel.text != nil){
                lengthOccupied = Float( imageView.frame.size.width + titleLabel.frame.size.width );
                
                
                if (imageView.frame.origin.x > titleLabel.frame.origin.x){
                    lengthOccupied += Float( imageView.frame.origin.x )
                }
                else {
                    lengthOccupied += Float( titleLabel.frame.origin.x )
                }
            }
            else if (imageView.image != nil){
                lengthOccupied = Float( imageView.frame.size.width + imageView.frame.origin.x )
            }
            else if (titleLabel.text != nil){
                lengthOccupied = Float( titleLabel.frame.size.width + imageView.frame.origin.x )
            }
            
            x =  Float(lengthOccupied) + Float( self.activityIndicatorEdgeInsets.left )
            if ( Float(x) + Float(frame.size.width) > Float(self.frame.size.width) ){
                x = Float(self.frame.size.width) - Float(frame.size.width + self.activityIndicatorEdgeInsets.right);
            }
            else if ( Float(x + Float(frame.size.width) ) > Float(self.frame.size.width - self.activityIndicatorEdgeInsets.right)){
                x = Float(self.frame.size.width) - ( Float(frame.size.width) + Float(self.activityIndicatorEdgeInsets.right) );
            }

            frame.origin.x = CGFloat(x);
        }
        
        return frame;
    }
    
    
    // UIImage clear
    fileprivate func clearImage(_ size:CGSize, scale:CGFloat) ->UIImage {
        UIGraphicsBeginImageContext(size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        UIGraphicsPushContext(context)
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        UIGraphicsPopContext()
        let outputImage:UIImage  = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return  UIImage(cgImage: outputImage.cgImage!, scale: scale, orientation: UIImageOrientation.up)
    }
    
    
    /** Store values */
    /** Value in Dictionary on ControlState */
    fileprivate func storeValue(_ value:AnyObject?, onDic:NSMutableDictionary!, state:UIControlState) {
        if let _value: AnyObject = value  {
            onDic.setValue(_value, forKey: "\(state.rawValue)")
        }
        else {
            onDic.removeObject(forKey: "\(state.rawValue)")
        }
        self.configureControlState(self.currentControlState())
    }
    
    
    // MARK: - KVO - Key-value Observer
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        configureControlState(currentControlState());
    }
    
}

