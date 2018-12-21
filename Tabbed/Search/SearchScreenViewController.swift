import UIKit
import RxSwift
import RxCocoa

class SearchScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    var viewModel  = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchController()
        
        // Do any additional setup after loading the view.
        
        viewModel.data.drive(tableView.rx.items(cellIdentifier: "Cell")) { _,
            repository, cell in
            cell.textLabel?.text = repository.name
            cell.detailTextLabel?.text =  repository.url
        }.disposed(by: disposeBag)
        
//        searchBar.rx.text
//            .bind(to: viewModel.searchText )
//            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .map {""}
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        viewModel.data.asDriver()
            .map { "\($0.count) Repositories" }
        .drive(navigationItem.rx.title)
        .disposed(by: disposeBag)
        
        
        
    }
    
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchBar.showsCancelButton = true
        searchBar.text = "krassik"
        searchBar.placeholder = "Enter GitHubID"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
