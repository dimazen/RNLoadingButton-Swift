//
//  NVActivityIndicatorView.swift
//  NVActivityIndicatorViewDemo
//
//  Created by Nguyen Vinh on 7/21/15.
//  Copyright (c) 2015 Nguyen Vinh. All rights reserved.
//

import UIKit

/**
 Enum of animation types used for activity indicator view.
 
 - Blank:                   Blank animation.
 - BallPulse:               BallPulse animation.
 - BallGridPulse:           BallGridPulse animation.
 - BallClipRotate:          BallClipRotate animation.
 - SquareSpin:              SquareSpin animation.
 - BallClipRotatePulse:     BallClipRotatePulse animation.
 - BallClipRotateMultiple:  BallClipRotateMultiple animation.
 - BallPulseRise:           BallPulseRise animation.
 - BallRotate:              BallRotate animation.
 - CubeTransition:          CubeTransition animation.
 - BallZigZag:              BallZigZag animation.
 - BallZigZagDeflect:       BallZigZagDeflect animation.
 - BallTrianglePath:        BallTrianglePath animation.
 - BallScale:               BallScale animation.
 - LineScale:               LineScale animation.
 - LineScaleParty:          LineScaleParty animation.
 - BallScaleMultiple:       BallScaleMultiple animation.
 - BallPulseSync:           BallPulseSync animation.
 - BallBeat:                BallBeat animation.
 - LineScalePulseOut:       LineScalePulseOut animation.
 - LineScalePulseOutRapid:  LineScalePulseOutRapid animation.
 - BallScaleRipple:         BallScaleRipple animation.
 - BallScaleRippleMultiple: BallScaleRippleMultiple animation.
 - BallSpinFadeLoader:      BallSpinFadeLoader animation.
 - LineSpinFadeLoader:      LineSpinFadeLoader animation.
 - TriangleSkewSpin:        TriangleSkewSpin animation.
 - Pacman:                  Pacman animation.
 - BallGridBeat:            BallGridBeat animation.
 - SemiCircleSpin:          SemiCircleSpin animation.
 - BallRotateChase:         BallRotateChase animation.
 */
public enum NVActivityIndicatorType {
    /**
     Blank.
     
     - returns: Instance of NVActivityIndicatorAnimationBlank.
     */
    case blank
    /**
     BallPulse.
     
     - returns: Instance of NVActivityIndicatorAnimationBallPulse.
     */
    case ballPulse
    /**
     BallGridPulse.
     
     - returns: Instance of NVActivityIndicatorAnimationBallGridPulse.
     */
    case ballGridPulse
    /**
     BallClipRotate.
     
     - returns: Instance of NVActivityIndicatorAnimationBallClipRotate.
     */
    case ballClipRotate
    /**
     SquareSpin.
     
     - returns: Instance of NVActivityIndicatorAnimationSquareSpin.
     */
    case squareSpin
    /**
     BallClipRotatePulse.
     
     - returns: Instance of NVActivityIndicatorAnimationBallClipRotatePulse.
     */
    case ballClipRotatePulse
    /**
     BallClipRotateMultiple.
     
     - returns: Instance of NVActivityIndicatorAnimationBallClipRotateMultiple.
     */
    case ballClipRotateMultiple
    /**
     BallPulseRise.
     
     - returns: Instance of NVActivityIndicatorAnimationBallPulseRise.
     */
    case ballPulseRise
    /**
     BallRotate.
     
     - returns: Instance of NVActivityIndicatorAnimationBallRotate.
     */
    case ballRotate
    /**
     CubeTransition.
     
     - returns: Instance of NVActivityIndicatorAnimationCubeTransition.
     */
    case cubeTransition
    /**
     BallZigZag.
     
     - returns: Instance of NVActivityIndicatorAnimationBallZigZag.
     */
    case ballZigZag
    /**
     BallZigZagDeflect
     
     - returns: Instance of NVActivityIndicatorAnimationBallZigZagDeflect
     */
    case ballZigZagDeflect
    /**
     BallTrianglePath.
     
     - returns: Instance of NVActivityIndicatorAnimationBallTrianglePath.
     */
    case ballTrianglePath
    /**
     BallScale.
     
     - returns: Instance of NVActivityIndicatorAnimationBallScale.
     */
    case ballScale
    /**
     LineScale.
     
     - returns: Instance of NVActivityIndicatorAnimationLineScale.
     */
    case lineScale
    /**
     LineScaleParty.
     
     - returns: Instance of NVActivityIndicatorAnimationLineScaleParty.
     */
    case lineScaleParty
    /**
     BallScaleMultiple.
     
     - returns: Instance of NVActivityIndicatorAnimationBallScaleMultiple.
     */
    case ballScaleMultiple
    /**
     BallPulseSync.
     
     - returns: Instance of NVActivityIndicatorAnimationBallPulseSync.
     */
    case ballPulseSync
    /**
     BallBeat.
     
     - returns: Instance of NVActivityIndicatorAnimationBallBeat.
     */
    case ballBeat
    /**
     LineScalePulseOut.
     
     - returns: Instance of NVActivityIndicatorAnimationLineScalePulseOut.
     */
    case lineScalePulseOut
    /**
     LineScalePulseOutRapid.
     
     - returns: Instance of NVActivityIndicatorAnimationLineScalePulseOutRapid.
     */
    case lineScalePulseOutRapid
    /**
     BallScaleRipple.
     
     - returns: Instance of NVActivityIndicatorAnimationBallScaleRipple.
     */
    case ballScaleRipple
    /**
     BallScaleRippleMultiple.
     
     - returns: Instance of NVActivityIndicatorAnimationBallScaleRippleMultiple.
     */
    case ballScaleRippleMultiple
    /**
     BallSpinFadeLoader.
     
     - returns: Instance of NVActivityIndicatorAnimationBallSpinFadeLoader.
     */
    case ballSpinFadeLoader
    /**
     LineSpinFadeLoader.
     
     - returns: Instance of NVActivityIndicatorAnimationLineSpinFadeLoader.
     */
    case lineSpinFadeLoader
    /**
     TriangleSkewSpin.
     
     - returns: Instance of NVActivityIndicatorAnimationTriangleSkewSpin.
     */
    case triangleSkewSpin
    /**
     Pacman.
     
     - returns: Instance of NVActivityIndicatorAnimationPacman.
     */
    case pacman
    /**
     BallGridBeat.
     
     - returns: Instance of NVActivityIndicatorAnimationBallGridBeat.
     */
    case ballGridBeat
    /**
     SemiCircleSpin.
     
     - returns: Instance of NVActivityIndicatorAnimationSemiCircleSpin.
     */
    case semiCircleSpin
    /**
     BallRotateChase.
     
     - returns: Instance of NVActivityIndicatorAnimationBallRotateChase.
     */
    case ballRotateChase
    
    fileprivate func animation() -> NVActivityIndicatorAnimationDelegate {
        switch self {
        case .blank:
            return NVActivityIndicatorAnimationBlank()
        case .ballPulse:
            return NVActivityIndicatorAnimationBallPulse()
        case .ballGridPulse:
            return NVActivityIndicatorAnimationBallGridPulse()
        case .ballClipRotate:
            return NVActivityIndicatorAnimationBallClipRotate()
        case .squareSpin:
            return NVActivityIndicatorAnimationSquareSpin()
        case .ballClipRotatePulse:
            return NVActivityIndicatorAnimationBallClipRotatePulse()
        case .ballClipRotateMultiple:
            return NVActivityIndicatorAnimationBallClipRotateMultiple()
        case .ballPulseRise:
            return NVActivityIndicatorAnimationBallPulseRise()
        case .ballRotate:
            return NVActivityIndicatorAnimationBallRotate()
        case .cubeTransition:
            return NVActivityIndicatorAnimationCubeTransition()
        case .ballZigZag:
            return NVActivityIndicatorAnimationBallZigZag()
        case .ballZigZagDeflect:
            return NVActivityIndicatorAnimationBallZigZagDeflect()
        case .ballTrianglePath:
            return NVActivityIndicatorAnimationBallTrianglePath()
        case .ballScale:
            return NVActivityIndicatorAnimationBallScale()
        case .lineScale:
            return NVActivityIndicatorAnimationLineScale()
        case .lineScaleParty:
            return NVActivityIndicatorAnimationLineScaleParty()
        case .ballScaleMultiple:
            return NVActivityIndicatorAnimationBallScaleMultiple()
        case .ballPulseSync:
            return NVActivityIndicatorAnimationBallPulseSync()
        case .ballBeat:
            return NVActivityIndicatorAnimationBallBeat()
        case .lineScalePulseOut:
            return NVActivityIndicatorAnimationLineScalePulseOut()
        case .lineScalePulseOutRapid:
            return NVActivityIndicatorAnimationLineScalePulseOutRapid()
        case .ballScaleRipple:
            return NVActivityIndicatorAnimationBallScaleRipple()
        case .ballScaleRippleMultiple:
            return NVActivityIndicatorAnimationBallScaleRippleMultiple()
        case .ballSpinFadeLoader:
            return NVActivityIndicatorAnimationBallSpinFadeLoader()
        case .lineSpinFadeLoader:
            return NVActivityIndicatorAnimationLineSpinFadeLoader()
        case .triangleSkewSpin:
            return NVActivityIndicatorAnimationTriangleSkewSpin()
        case .pacman:
            return NVActivityIndicatorAnimationPacman()
        case .ballGridBeat:
            return NVActivityIndicatorAnimationBallGridBeat()
        case .semiCircleSpin:
            return NVActivityIndicatorAnimationSemiCircleSpin()
        case .ballRotateChase:
            return NVActivityIndicatorAnimationBallRotateChase()
        }
    }
}

open class NVActivityIndicatorView: UIView {
	public static let DEFAULT_TYPE: NVActivityIndicatorType = .pacman
	public static let DEFAULT_COLOR = UIColor.white
	public static let DEFAULT_SIZE: CGSize = CGSize(width: 40, height: 40)
    
    /// Animation type, value of NVActivityIndicatorType enum.
    open var type: NVActivityIndicatorType
    
    /// Color of activity indicator view.
    open var color: UIColor
    
    /// Actual size of animation in view.
    open var size: CGSize
    
    /// Current status of animation, this is not used to start or stop animation.
    open var animating: Bool = false
    
    /// Specify whether activity indicator view should hide once stopped.
    open var hidesWhenStopped: Bool = true
    
    /**
     Create a activity indicator view with default type, color and size.\n
     This is used by storyboard to initiate the view.
     
     - Default type is pacman.\n
     - Default color is white.\n
     - Default size is 40.
     
     - parameter decoder:
     
     - returns: The activity indicator view.
     */
    required public init?(coder aDecoder: NSCoder) {
        self.type = NVActivityIndicatorView.DEFAULT_TYPE
        self.color = NVActivityIndicatorView.DEFAULT_COLOR
        self.size = NVActivityIndicatorView.DEFAULT_SIZE
        super.init(coder: aDecoder);
        super.backgroundColor = UIColor.clear
    }
    
    /**
     Create a activity indicator view with specified type, color, size and size.
     
     - parameter frame: view's frame.
     - parameter type: animation type, value of NVActivityIndicatorType enum. Default type is pacman.
     - parameter color: color of activity indicator view. Default color is white.
     - parameter size: actual size of animation in view. Default size is 40.
     
     - returns: The activity indicator view.
     */
    public init(frame: CGRect, type: NVActivityIndicatorType = DEFAULT_TYPE, color: UIColor = DEFAULT_COLOR, size: CGSize = DEFAULT_SIZE) {
        self.type = type
        self.color = color
        self.size = size
        super.init(frame: frame)
    }
    
    /**
     Start animation.
     */
    open func startAnimation() {
        if hidesWhenStopped && isHidden {
            isHidden = false
        }
        if (self.layer.sublayers == nil) {
            setUpAnimation()
        }
        self.layer.speed = 1
        self.animating = true
    }
    
    /**
     Stop animation.
     */
    open func stopAnimation() {
        self.layer.sublayers = nil
        self.animating = false
        if hidesWhenStopped && !isHidden {
            isHidden = true
        }
    }
    
    // MARK: Privates
    
    fileprivate func setUpAnimation() {
        let animation: NVActivityIndicatorAnimationDelegate = self.type.animation()
        
        self.layer.sublayers = nil
        animation.setUpAnimationInLayer(self.layer, size: self.size, color: self.color)
    }
}
