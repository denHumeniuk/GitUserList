import UIKit

class GitListViewController: DABasicViewController {

    let model = GitListModel()
    
    var customView : GitListView {
        return self.view as! GitListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GitHub Users"
        customView.viewDataSource = self
        customView.viewDelegate = self
        model.downloadCompletion = { [weak self] in self?.downloadCompletion($0) }
        model.getUsers()
    }

    //MARK: -
    
    
    override func startDownloadAction() {
        if model.firstDownload {
            super.startDownloadAction()
        } else {
            customView.tablaViewStartLoadMoreData()
        }
    }
    
    override func endDownloadAction() {
        DispatchQueue.main.async {
            if self.model.firstDownload {
                super.endDownloadAction()
                self.model.firstDownload = false
                self.customView.reloadTableVeiew()
            } else {
                self.customView.tablaViewFinishLoadMoreData()
                self.model.changeNeedUpdate()
            }
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFollowers" {
            guard let user = sender as? User, let viewController = segue.destination as? UserFollowersListViewController else { return }
            viewController.model.setUser(user: user)
        }
    }
}

extension GitListViewController : TableDataSourceWhithUpdateMod {
    
    var numberOfRow: Int {
        return model.listOfUserCount
    }
    
    var isNeedMoreLoad: Bool {
        return model.isNeedTableViewUpdate
    }
    
    func getUser(at index: Int) -> Codable? {
        return model.getUser(at: index)
    }
    
}

extension GitListViewController: TableDatUpdateModDelegate {
   
    func needMoreData() {
        guard model.isNeedTableViewUpdate == true else { return }
        model.changeNeedUpdate()
        model.getUsers()
    }
    func cellIsTapped(index: Int) {
        performSegue(withIdentifier: "toFollowers", sender:  model.getUser(at: index))
    }
    
    
    
}
