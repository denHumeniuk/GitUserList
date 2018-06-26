import Foundation

class DAModel : NSObject {
    public var downloadCompletion: ((LoadingState) -> ())?
}

class GitListModel: DAModel {
    
    //MARK: - DataSource
    private var listOfUser: [User] = []{
        didSet {
            guard listOfUser.count > 0, let lastUser = listOfUser.last else { return }
            lastSince = lastUser.id
        }
    }
    
    public var listOfUserCount : Int {
        return listOfUser.count
    }
    public func getUser(at index: Int) -> User? {
        guard index < listOfUser.count else { return nil }
        return listOfUser[index]
    }    
    
    //MARK: - Update users func
    var firstDownload: Bool = true
    private(set) var isNeedTableViewUpdate: Bool = true 
    private var lastSince: Int = 0
    public func changeNeedUpdate(){
        isNeedTableViewUpdate = !isNeedTableViewUpdate
    }
    
    //MARK: - API Func
    
    public func getUsers(){
        downloadCompletion?(.startDownload)
        APIService.shared.getUsers(since: lastSince){(result) in
            switch result {
            case .success(let users):
                defer { self.downloadCompletion?(.endDownload) }
                guard users != nil else { return }
                self.listOfUser.append(contentsOf: users!)
            case .failure(let error):
                print("error = \(error.localizedDescription)")
                self.downloadCompletion?(.error(error))
            }
        }
    }
}

