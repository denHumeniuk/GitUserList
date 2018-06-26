import Foundation
 
 
class FollowerModel: DAModel {
     //MARK: - Follower DataSource
    private var listOfFollower: [Follower] = []

    private var currentUser: User? = nil
    public func setUser(user: User){
        currentUser = user
    }
    
    // TableDataSource
    public var listOfFollowerCount : Int {
        return listOfFollower.count
    }
    public func getFollower(at index: Int) -> Follower? {
        guard index < listOfFollower.count else { return nil }
        return listOfFollower[index]
    }

    //MARK: - Update users func
    var firstDownload: Bool = true
    private(set) var isNeedTableViewUpdate: Bool = true
    private var currentPage: Int = 1
    public func changeNeedUpdate(){
        isNeedTableViewUpdate = !isNeedTableViewUpdate
    }
    
    //MARK: - API Func
    
    public func getFollowers(){
        guard currentUser != nil else { return }
        downloadCompletion?(.startDownload)
        APIService.shared.getListFollowers(of: currentUser!.login, page: currentPage){(result) in
            switch result {
            case .success(let followers):
                defer { self.downloadCompletion?(.endDownload) }
                guard followers != nil else { return }
                self.listOfFollower.append(contentsOf: followers!)
                self.currentPage += 1
            case .failure(let error):
                print("error = \(error.localizedDescription)")
                self.downloadCompletion?(.error(error))
            }
        }
    }
 }

 
