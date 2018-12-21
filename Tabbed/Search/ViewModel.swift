import Foundation

import RxSwift
import RxCocoa

class ViewModel {
    let searchText = Variable("")
    let disposeBag = DisposeBag()
    
    lazy var data: Driver<[Repository]> = {
       
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMapLatest {
                self.getRepositories(gitHubID: $0)
        }
        .asDriver(onErrorJustReturn: [])
    }()
    
    func getRepositories(gitHubID: String) -> Observable<[Repository]> {
        guard !gitHubID.isEmpty,
            let url = URL(string: "https://api.gitgub.com/users/\(gitHubID)/repos")
            else {
                    return Observable.just([])
                
            }
        
        return URLSession.shared.rx.json(request: URLRequest(url: url))
            .retry(3)
        //.catchErrorJustReturn([])
        //.observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map {
                var repositories = [Repository]()
                if let items = $0 as? [[String: AnyObject]] {
                    items.forEach {
                        guard let name = $0["name"] as? String,
                              let url = $0["html_url"] as? String
                            else { return }
                        repositories.append( Repository(name:name, url: url) )
                    }
                }
                
                return repositories
        }
    }
    
}
