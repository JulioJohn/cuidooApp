import UIKit

public extension UIView {

    /// Use this method to attach this view to it's Superview
    func bindFrameToSuperviewBounds(offset insets: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let superview = self.superview else {
            let errorMessage = """
                Error! `superview` was nil:
                – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.
            """
            print(errorMessage)
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        let horizontalFormat =  "H:|-\(insets.top)-[subview]-\(insets.bottom)-|"
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalFormat,
                                                                options: .directionLeadingToTrailing,
                                                                metrics: nil,
                                                                views: ["subview": self]))
        let verticalFormat = "V:|-\(insets.left)-[subview]-\(insets.right)-|"
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalFormat,
                                                                options: .directionLeadingToTrailing,
                                                                metrics: nil,
                                                                views: ["subview": self]))
    }
    
    func rotateView(imageView: UIImageView) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 1.0
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        imageView.layer.add(rotation, forKey: "rotationAnimation")
    }
}
