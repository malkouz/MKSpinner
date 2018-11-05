/*
 Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import UIKit

open class MKFullSpinner: UIView {
    
    // MARK: - Singleton
    
    //
    // Access the singleton instance
    //
    open class var sharedInstance: MKFullSpinner {
        struct Singleton {
            static let instance = MKFullSpinner(frame: CGRect.zero)
        }
        return Singleton.instance
    }
    
    // MARK: - Init
    
    //
    // Custom init to build the spinner UI
    //
    
    fileprivate var animationDuration: Double = 1.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        blurEffect = UIBlurEffect(style: blurEffectStyle)
        blurView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurView)
        
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        addSubview(vibrancyView)
        
        let titleScale: CGFloat = 0.85
        titleLabel.frame.size = CGSize(width: frameSize.width * titleScale, height: frameSize.height * titleScale)
        titleLabel.font = defaultTitleFont
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        
        vibrancyView.contentView.addSubview(titleLabel)
        blurView.contentView.addSubview(vibrancyView)
        
        outerCircleView.frame.size = frameSize
        
        outerCircle.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: frameSize.width, height: frameSize.height)).cgPath
        outerCircle.lineWidth = 8.0
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 0.45
        outerCircle.lineCap = CAShapeLayerLineCap.round
        outerCircle.fillColor = UIColor.clear.cgColor
        outerCircle.strokeColor = UIColor.white.cgColor
        outerCircleView.layer.addSublayer(outerCircle)
        
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 1.0
        
        vibrancyView.contentView.addSubview(outerCircleView)
        
        innerCircleView.frame.size = frameSize
        
        let innerCirclePadding: CGFloat = 12
        innerCircle.path = UIBezierPath(ovalIn: CGRect(x: innerCirclePadding, y: innerCirclePadding, width: frameSize.width - 2*innerCirclePadding, height: frameSize.height - 2*innerCirclePadding)).cgPath
        innerCircle.lineWidth = 4.0
        innerCircle.strokeStart = 0.5
        innerCircle.strokeEnd = 0.9
        innerCircle.lineCap = CAShapeLayerLineCap.round
        innerCircle.fillColor = UIColor.clear.cgColor
        innerCircle.strokeColor = UIColor.gray.cgColor
        innerCircleView.layer.addSublayer(innerCircle)
        
        innerCircle.strokeStart = 0.0
        innerCircle.strokeEnd = 1.0
        
        vibrancyView.contentView.addSubview(innerCircleView)
        
        isUserInteractionEnabled = true
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    
    // MARK: - Public interface
    
    open lazy var titleLabel = UILabel()
    open var subtitleLabel: UILabel?
    
    //
    // Show the spinner activity on screen, if visible only update the title
    //
    open class func show(_ title: String, animated: Bool = true, duration: Double = 1.0) -> MKFullSpinner {
        
        let window = UIApplication.shared.windows.first!
        let spinner = MKFullSpinner.sharedInstance
        spinner.animationDuration = duration
        spinner.showWithDelayBlock = nil
        spinner.clearTapHandler()
        
        
        
        if spinner.superview == nil {
            //show the spinner
            spinner.alpha = 0.0
            spinner.updateFrame()
            window.addSubview(spinner)
            
//            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                spinner.alpha = 1.0
//                }, completion: nil)
            
            // Orientation change observer
            NotificationCenter.default.addObserver(
                spinner,
                selector: #selector(updateFrame),
                name: UIApplication.didChangeStatusBarOrientationNotification,
                object: nil)
        }
        
        spinner.title = title
        spinner.animating = animated
        
        return spinner
    }
    
    //
    // Show the spinner activity on screen, after delay. If new call to show,
    // showWithDelay or hide is maked before execution this call is discarded
    //
    open class func showWithDelay(_ delay: Double, title: String, animated: Bool = true, duration: Double = 1.0) -> MKFullSpinner {
        let spinner = MKFullSpinner.sharedInstance
        
        spinner.showWithDelayBlock = {
            _ = MKFullSpinner.show(title, animated: animated)
        }
        
        spinner.delay(seconds: delay) { [weak spinner] in
            if let spinner = spinner {
                spinner.showWithDelayBlock?()
            }
        }
        
        return spinner
    }
    
    //
    // Hide the spinner
    //
    open class func hide(_ completion: (() -> Void)? = nil) {
        
        let spinner = MKFullSpinner.sharedInstance
        
        NotificationCenter.default.removeObserver(spinner)
        
        DispatchQueue.main.async(execute: {
            spinner.showWithDelayBlock = nil
            spinner.clearTapHandler()
            
            if spinner.superview == nil {
                return
            }
            
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                spinner.alpha = 0.0
                }, completion: {_ in
                    spinner.alpha = 1.0
                    spinner.removeFromSuperview()
                    spinner.titleLabel.font = spinner.defaultTitleFont
                    spinner.titleLabel.text = nil
                    
                    completion?()
            })
            
            spinner.animating = false
        })
    }
    
    //
    // Set the default title font
    //
    open class func setTitleFont(_ font: UIFont?) {
        let spinner = MKFullSpinner.sharedInstance
        
        if let font = font {
            spinner.titleLabel.font = font
        } else {
            spinner.titleLabel.font = spinner.defaultTitleFont
        }
    }
    
    //
    // The spinner title
    //
    open var title: String = "" {
        didSet {
            
            let spinner = MKFullSpinner.sharedInstance
            
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
                spinner.titleLabel.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                spinner.titleLabel.alpha = 0.2
                }, completion: {_ in
                    spinner.titleLabel.text = self.title
                    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: [], animations: {
                        spinner.titleLabel.transform = CGAffineTransform.identity
                        spinner.titleLabel.alpha = 1.0
                        }, completion: nil)
            })
        }
    }
    
    //
    // observe the view frame and update the subviews layout
    //
    open override var frame: CGRect {
        didSet {
            if frame == CGRect.zero {
                return
            }
            blurView.frame = bounds
            vibrancyView.frame = blurView.bounds
            titleLabel.center = vibrancyView.center
            outerCircleView.center = vibrancyView.center
            innerCircleView.center = vibrancyView.center
            if let subtitle = subtitleLabel {
                subtitle.bounds.size = subtitle.sizeThatFits(bounds.insetBy(dx: 20.0, dy: 0.0).size)
                subtitle.center = CGPoint(x: bounds.midX, y: bounds.maxY - subtitle.bounds.midY - subtitle.font.pointSize)
            }
        }
    }
    
    //
    // Start the spinning animation
    //
    
    open var animating: Bool = false {
        
        /* willSet (shouldAnimate) {
         if shouldAnimate && !animating {
         spinInner()
         spinOuter()
         }
         }*/
        
        didSet {
            // update UI
            if animating {
                spinInner()
                spinOuter()
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 0.45
                self.innerCircle.strokeStart = 0.5
                self.innerCircle.strokeEnd = 0.9
            } else {
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 1.0
                self.innerCircle.strokeStart = 0.0
                self.innerCircle.strokeEnd = 1.0
            }
        }
    }
    
    //
    // Tap handler
    //
    open func addTapHandler(_ tap: @escaping (()->()), subtitle subtitleText: String? = nil) {
        clearTapHandler()
        
        //vibrancyView.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapSpinner")))
        tapHandler = tap
        
        if subtitleText != nil {
            subtitleLabel = UILabel()
            if let subtitle = subtitleLabel {
                subtitle.text = subtitleText
                subtitle.font = UIFont(name: defaultTitleFont!.familyName, size: defaultTitleFont!.pointSize * 0.8)
                subtitle.textColor = UIColor.white
                subtitle.numberOfLines = 0
                subtitle.textAlignment = .center
                subtitle.lineBreakMode = .byWordWrapping
                subtitle.bounds.size = subtitle.sizeThatFits(bounds.insetBy(dx: 20.0, dy: 0.0).size)
                subtitle.center = CGPoint(x: bounds.midX, y: bounds.maxY - subtitle.bounds.midY - subtitle.font.pointSize)
                vibrancyView.contentView.addSubview(subtitle)
            }
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if tapHandler != nil {
            tapHandler?()
            tapHandler = nil
        }
    }
    
    open func clearTapHandler() {
        isUserInteractionEnabled = false
        subtitleLabel?.removeFromSuperview()
        tapHandler = nil
    }
    
    // MARK: - Private interface
    
    //
    // layout elements
    //
    
    fileprivate var blurEffectStyle: UIBlurEffect.Style = .dark
    fileprivate var blurEffect: UIBlurEffect!
    fileprivate var blurView: UIVisualEffectView!
    fileprivate var vibrancyView: UIVisualEffectView!
    
    var defaultTitleFont:UIFont? = UIFont(name: "HelveticaNeue", size: 22.0)! // UIFont(name: "HelveticaNeue", size: CGFloat(22.0))!
    let frameSize = CGSize(width: 200.0, height: 200.0)
    
    fileprivate lazy var outerCircleView = UIView()
    fileprivate lazy var innerCircleView = UIView()
    
    fileprivate let outerCircle = CAShapeLayer()
    fileprivate let innerCircle = CAShapeLayer()
    
    fileprivate var showWithDelayBlock: (()->())?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    fileprivate var currentOuterRotation: CGFloat = 0.0
    fileprivate var currentInnerRotation: CGFloat = 0.1
    
    fileprivate func spinOuter() {
        
        if superview == nil {
            return
        }
        
        /*let duration = Double(Float(arc4random()) /  Float(UInt32.max)) * 2.0 + 1.5
         let randomRotation = Double(Float(arc4random()) /  Float(UInt32.max)) * M_PI_4 + M_PI_4
         
         //outer circle
         UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
         self.currentOuterRotation -= CGFloat(randomRotation)
         self.outerCircleView.transform = CGAffineTransformMakeRotation(self.currentOuterRotation)
         }, completion: {_ in
         let waitDuration = Double(Float(arc4random()) /  Float(UInt32.max)) * 1.0 + 1.0
         self.delay(seconds: waitDuration, completion: {
         if self.animating {
         self.spinOuter()
         }
         })
         })*/
        if self.animating {
            let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
            
            rotation.duration = animationDuration
            rotation.isRemovedOnCompletion = false
            rotation.repeatCount = HUGE
            rotation.fillMode = CAMediaTimingFillMode.forwards
            rotation.fromValue = NSNumber(value: 0.0 as Float)
            rotation.toValue = NSNumber(value: 3.14 * 2.0 as Float)
            
            self.outerCircleView.layer.add(rotation, forKey: "rotate")
        }
    }
    
    fileprivate func spinInner() {
        if superview == nil {
            return
        }
        
        //inner circle
        /*UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
         self.currentInnerRotation += CGFloat(M_PI_4)
         self.innerCircleView.transform = CGAffineTransformMakeRotation(self.currentInnerRotation)
         }, completion: {_ in
         self.delay(seconds: 0.5, completion: {
         if self.animating {
         self.spinInner()
         }
         })
         })*/
        if self.animating {
            let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
            
            rotation.duration = animationDuration
            rotation.isRemovedOnCompletion = false
            rotation.repeatCount = HUGE
            rotation.fillMode = CAMediaTimingFillMode.forwards
            rotation.fromValue = NSNumber(value: 0.0 as Float)
            rotation.toValue = NSNumber(value: -3.14 * 2.0 as Float)
            
            self.innerCircleView.layer.add(rotation, forKey: "rotate")
        }
    }
    
    @objc open func updateFrame() {
        let window = UIApplication.shared.windows.first!
        MKFullSpinner.sharedInstance.frame = window.frame
    }
    
    // MARK: - Util methods
    
    func delay(seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: - Tap handler
    fileprivate var tapHandler: (()->())?
    func didTapSpinner() {
        tapHandler?()
    }
}

