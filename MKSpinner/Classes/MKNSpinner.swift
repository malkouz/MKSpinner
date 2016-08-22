//
//  Spinner.swift //costomized Spinner
//  MKSpinner
//
//  Created by Moayad on 10/10/15.
//  Copyright © 2015 Moayad. All rights reserved.
//

import UIKit



public class MKNSpinner: UIView {
    
    enum SpinnerStyle : Int{
        case None = 0
        case Light = 1
        case Dark = 2
    }
    
    var Style : SpinnerStyle = .None
    
    public var hidesWhenStopped : Bool = false
    
    public var outerFillColor : UIColor = UIColor.clearColor()
    public var outerStrokeColor : UIColor = UIColor.grayColor()
    public var outerLineWidth : CGFloat = 5.0
    public var outerEndStroke : CGFloat = 0.5
    public var outerAnimationDuration : CGFloat = 2.0
    
    public var enableInnerLayer : Bool = true
    
    public var innerFillColor : UIColor  = UIColor.clearColor()
    public var innerStrokeColor : UIColor = UIColor.grayColor()
    public var innerLineWidth : CGFloat = 5.0
    public var innerEndStroke : CGFloat = 0.5
    public var innerAnimationDuration : CGFloat = 1.6
    
    public var labelText : String  = ""
    public var labelFont : String  = "Helvetica"
    public var labelTextColor : UIColor  = UIColor.blackColor()
    
    public var labelFontSize : CGFloat = 11.0
    
    var currentInnerRotation : CGFloat = 0
    var currentOuterRotation : CGFloat = 0
    
    var innerView : UIView = UIView()
    var outerView : UIView = UIView()
    
    var label: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.commonInit()
    }
    
    func commonInit(){
        self.Style = MKNSpinner.SpinnerStyle.Light
        let background = UIView(frame: self.frame)
        background.alpha = 0.75
        background.backgroundColor = UIColor(red: 43.0/255.0, green: 132.0/255.0, blue: 200.0/255.0, alpha: 1)
        background.layer.cornerRadius = 10
        background.clipsToBounds = true
        
        addSubview(background)
        
        
        
        
        
        self.backgroundColor = UIColor.clearColor()
        
        switch Style{
        case .Dark:
            outerStrokeColor = UIColor.grayColor()
            innerStrokeColor = UIColor.grayColor()
            labelTextColor = UIColor.grayColor()
        case .Light:
            outerStrokeColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
            innerStrokeColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
            labelTextColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
        case .None:
            break
        }
        
        
        self.addSubview(outerView)
        outerView.frame = CGRectMake(10 , 10, self.frame.size.width-20, self.frame.size.height-20)
        outerView.center = self.center//self.convertPoint(self.center, fromCoordinateSpace: self.superview!)
        
        let outerLayer = CAShapeLayer()
        outerLayer.path = UIBezierPath(ovalInRect: outerView.bounds).CGPath
        outerLayer.lineWidth = outerLineWidth
        outerLayer.strokeStart = 0.0
        outerLayer.strokeEnd = outerEndStroke
        outerLayer.lineCap = kCALineCapRound
        outerLayer.fillColor = outerFillColor.CGColor
        outerLayer.strokeColor = outerStrokeColor.CGColor
        outerView.layer.addSublayer(outerLayer)
        
        if enableInnerLayer{
            
            self.addSubview(innerView)
            innerView.frame = CGRectMake(0 , 0, self.frame.size.width - 40, self.frame.size.height - 40)
            innerView.center =  self.center//self.convertPoint(self.center, fromCoordinateSpace: self.superview!)
            let innerLayer = CAShapeLayer()
            innerLayer.path = UIBezierPath(ovalInRect: innerView.bounds).CGPath
            innerLayer.lineWidth = innerLineWidth
            innerLayer.strokeStart = 0
            innerLayer.strokeEnd = innerEndStroke
            innerLayer.lineCap = kCALineCapRound
            innerLayer.fillColor = innerFillColor.CGColor
            innerLayer.strokeColor = innerStrokeColor.CGColor
            
            innerView.layer.addSublayer(innerLayer)
        }
        
        label = UILabel(frame: CGRectMake(0, 0, 100, 21))
        
        label.text = labelText
        label.textColor = labelTextColor
        label.font = UIFont(name: labelFont, size: labelFontSize)
        
        self.addSubview(label)
        /*if enableInnerLayer{
         label.frame.size.width = innerView.frame.size.width/1.20
         label.frame.size.height = innerView.frame.size.height
         }
         else{
         label.frame.size.width = outerView.frame.size.width/1.2
         label.frame.size.height = outerView.frame.size.height
         }*/
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.textAlignment = .Center
        label.center = self.center//self.convertPoint(self.center, fromCoordinateSpace: self.superview!)
        
        self.startAnimating()
    }
    
    
    func animateInnerRing(){
        if((self.innerView.layer.animationForKey("rotateInner")) == nil){
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.fromValue = 0 * CGFloat(M_PI/180)
            rotationAnimation.toValue = 360 * CGFloat(M_PI/180)
            rotationAnimation.duration = Double(innerAnimationDuration)
            rotationAnimation.repeatCount = HUGE
            self.innerView.layer.addAnimation(rotationAnimation, forKey: "rotateInner")
        }
        
    }
    func animateOuterRing(){
        if((self.outerView.layer.animationForKey("rotateOuter")) == nil){
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.fromValue = 360 * CGFloat(M_PI/180)
            rotationAnimation.toValue = 0 * CGFloat(M_PI/180)
            rotationAnimation.duration = Double(outerAnimationDuration)
            rotationAnimation.repeatCount = HUGE
            self.outerView.layer.addAnimation(rotationAnimation, forKey: "rotateOuter")
        }
    }
    
    func startAnimating(){
        
        self.hidden = false
        
        self.animateOuterRing()
        self.animateInnerRing()
    }
    
    func stopAnimating(){
        if hidesWhenStopped{
            self.hidden = true
        }
        self.outerView.layer.removeAllAnimations()
        self.innerView.layer.removeAllAnimations()
        
    }
    
    var isShown:Bool = false
    
    func updateFrame() {
        let window:UIWindow = UIApplication.sharedApplication().windows.first!
        MKNSpinner.sharedInstance.center = window.center
    }
    
    public class var sharedInstance: MKNSpinner {
        struct Singleton {
            static let instance = MKNSpinner(frame: CGRectMake(0,0,140,140))
        }
        return Singleton.instance
    }
    
    public class func show(title: String, animated: Bool = true) -> MKNSpinner {

        let window = UIApplication.sharedApplication().windows.first!
        let spinner = MKNSpinner.sharedInstance

        if(!UIApplication.sharedApplication().isIgnoringInteractionEvents()){
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        }
        spinner.updateFrame()
        
        if spinner.superview == nil {
            //show the spinner
            spinner.alpha = 0.0
            window.addSubview(spinner)
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.alpha = 1.0
                }, completion: nil)
            
            // Orientation change observer
            NSNotificationCenter.defaultCenter().addObserver(
                spinner,
                selector: #selector(updateFrame),
                name: UIApplicationDidChangeStatusBarOrientationNotification,
                object: nil)
        }
        
        spinner.label.text = title
        spinner.isShown = true
        spinner.startAnimating()
        return spinner
        
    }
    
    public class func hide(completion: (() -> Void)? = nil) {
        
        let spinner = MKNSpinner.sharedInstance
        
        NSNotificationCenter.defaultCenter().removeObserver(spinner)
        
        dispatch_async(dispatch_get_main_queue(), {
            if(UIApplication.sharedApplication().isIgnoringInteractionEvents()){
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            }
            //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            spinner.userInteractionEnabled = true
            if spinner.superview == nil {
                spinner.isShown = false
                return
            }
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.alpha = 0.0
                }, completion: {_ in
                    spinner.alpha = 1.0
                    spinner.removeFromSuperview()
                    
                    spinner.isShown = false
                    completion?()
            })
        })
        
    }
}
