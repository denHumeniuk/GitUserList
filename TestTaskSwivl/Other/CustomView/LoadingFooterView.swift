import UIKit

class LoadingFooterView : UIView {
    
    @IBOutlet private weak var loadingTextLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private(set) var isLoading: Bool = false {
        didSet{
            guard isLoading != oldValue else { return }
            switch isLoading {
            case true:
                activityIndicator.startAnimating()
            case false:
                activityIndicator.stopAnimating()
            }
        }
    }
    
    //MARK: - Init and setup FUNC
    private var nibName = "LoadingFooterView"
    private var nibView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func loadFromNib()-> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func setup() {
        nibView = loadFromNib()
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
    }
    
}

    //MARK: - View Public Interface
extension LoadingFooterView {
    
    public func setLoadingText(_ text: String){
        loadingTextLabel.text = text
        self.layoutIfNeeded()
    }
    
    public func changeIndicatorStatus(newStatus: Bool){
        isLoading = newStatus
    }
    
}

