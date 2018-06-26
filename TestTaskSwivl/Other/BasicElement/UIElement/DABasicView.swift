import UIKit

class DABasicView: UIView {
    
    private var activityIndicator: UIActivityIndicatorView? {
        willSet {
            if let activityIndicator = newValue {
                addSubview(activityIndicator)
                activityIndicator.startAnimating()
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
    
    public var showIndicator: Bool! {
        get { return activityIndicator != nil }
        set { newValue ? (activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)) : (activityIndicator = nil) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            self.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}
