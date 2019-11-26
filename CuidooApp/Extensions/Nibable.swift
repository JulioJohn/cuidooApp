
import UIKit

/// Use this protocol to be able to load a XIB file as a View of the same name of your UIView Class
public protocol Nibable where Self: UIView {
    /// This method loads a XIB with the same name from this UIView file.
    /// Set this method at init(frame: CGRect) from your view.
    func loadNib()
}

extension Nibable where Self: UIView {
    /// This method returns the name from this Nib
    public func nibName() -> String? {
        return type(of: self).description().components(separatedBy: ".").last
    }

    private func loadViewFromXibFile(name: String?) -> UIView? {
        guard let name = name else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    public func loadNib() {
        guard let view = loadViewFromXibFile(name: nibName()) else { return }
        self.addSubview(view)
        view.bindFrameToSuperviewBounds()
        view.backgroundColor = .clear
    }
}

