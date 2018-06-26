import UIKit

protocol TableDataSourceWhithUpdateMod: class {
    var numberOfRow: Int {get}
    var isNeedMoreLoad: Bool {get}
    func getUser(at index: Int)->Codable?
}
protocol TableDatUpdateModDelegate: class {
    func needMoreData()
    func cellIsTapped(index: Int)
}

class GitListView: DABasicView {
    
    @IBOutlet weak private var tableView : UITableView!
    
    weak var viewDataSource: TableDataSourceWhithUpdateMod?{
        didSet{
            guard viewDataSource != nil else {
                return
            }
            tableView.reloadData()
        }
    }
    weak var viewDelegate: TableDatUpdateModDelegate?
    
    var loadMoreStatus = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configTableView()
    }
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        let footerView = LoadingFooterView()
        footerView.frame.size.height = 60.0
        footerView.setLoadingText("download more...")
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            guard let isNeed = viewDataSource?.isNeedMoreLoad, isNeed == true  else { return }
            viewDelegate?.needMoreData()
        }
    }
    
    
    public func tablaViewStartLoadMoreData(){
        guard let footerView = tableView.tableFooterView as? LoadingFooterView, footerView.isLoading != true else { return }
        footerView.changeIndicatorStatus(newStatus: true)
        tableView.tableFooterView?.isHidden = false
    }

    public func tablaViewFinishLoadMoreData(){
        guard let footerView = tableView.tableFooterView as? LoadingFooterView, footerView.isLoading == true else { return }
        footerView.changeIndicatorStatus(newStatus: false)
        tableView.tableFooterView?.isHidden = true
        reloadTableVeiew()
    }
    
    public func reloadTableVeiew(){
        self.tableView.reloadData()
    }
    
}


extension GitListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataSource?.numberOfRow ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! GitUserCell
        guard let user = viewDataSource?.getUser(at: indexPath.row) as? User else {
            return UITableViewCell()
        }
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewDelegate?.cellIsTapped(index: indexPath.row)
    }
    
}
