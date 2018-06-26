import UIKit

class UserFollowersListViewController: DABasicViewController {
    
    let model = FollowerModel()
    
    var customView : UserFollowersListView {
        return self.view as! UserFollowersListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Followers"
        customView.viewDataSource = self
        customView.viewDelegate = self
        model.downloadCompletion = { [weak self] in self?.downloadCompletion($0) }
        model.getFollowers()
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
    
}

extension UserFollowersListViewController : TableDataSourceWhithUpdateMod {
    
    var numberOfRow: Int {
        return model.listOfFollowerCount
    }
    
    var isNeedMoreLoad: Bool {
        return true
    }
    
    func getUser(at index: Int) -> Codable? {
        return model.getFollower(at: index)
    }
    
}

extension UserFollowersListViewController: TableDatUpdateModDelegate {

    func needMoreData() {
        guard model.isNeedTableViewUpdate else { return }
        model.changeNeedUpdate()
        model.getFollowers()
    }
    
    func cellIsTapped(index: Int) {
        print("")
    }
    
    
}
