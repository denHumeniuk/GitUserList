import UIKit

enum ViewControllerState {
    case normal
    case download
}

enum LoadingState {
    case startDownload
    case endDownload
    case error(Error)
}

class DABasicViewController: UIViewController{
    
    public var vcState: ViewControllerState = .normal {
        didSet{
            guard let basicView = view as? DABasicView else { return }
            switch vcState {
            case .normal:
                if basicView.showIndicator ==  true { basicView.showIndicator = false }
            case .download:
                basicView.showIndicator =  true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarConfig()
    }
    
    final public func downloadCompletion(_ state: LoadingState) {
        switch state{
        case .startDownload:
            startDownloadAction()
        case .endDownload:
            endDownloadAction()
        case .error(let err):
            errorDownloadAction(with: err)
        }
    }
    
    public func startDownloadAction(){
        print("start")
        vcState = .download
    }
    public func endDownloadAction(){
        guard vcState != .normal else {return}
        DispatchQueue.main.async {
            self.vcState = .normal
        }
        print("end")
    }
    public func errorDownloadAction(with error: Error){
        print("error")
        DispatchQueue.main.async {
            self.vcState = .normal
            self.showErrorAlert(message: error.localizedDescription)
        }
    }
    
    private func showErrorAlert(title: String = "Error", message: String = "API Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

extension DABasicViewController {
    
    func navBarConfig(){
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 36/255, green: 41/255, blue: 46/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        navigationController?.navigationBar.tintColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}

