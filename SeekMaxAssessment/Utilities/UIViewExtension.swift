import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    ///
    public func constraints(pinningEdgesTo view: UIView) -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        return constraints
    }
    
    ///
    public func constraints(pinningEdgesTo layoutGuide: UILayoutGuide) -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = [
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
        ]
        return constraints
    }
    
    ///
    public func constraints(centeringIn view: UIView) -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        return constraints
    }
    
    func usesAutolayout(_ usesAutolayout: Bool) {
        translatesAutoresizingMaskIntoConstraints = !usesAutolayout
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
