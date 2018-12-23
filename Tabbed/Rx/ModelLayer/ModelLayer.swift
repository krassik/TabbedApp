import Foundation
import RxSwift


typealias MessagesClosure = ([Message]) -> Void

class ModelLayer {
    private var bag = DisposeBag()
    private var networkLayer = NetworkLayer() //normally injected as an interface
    
    let messages = Variable<[Message]>([])
    static let shared = ModelLayer()
}

extension ModelLayer {
    
    func loadMessage() {
        loadMessage { messages in
            print(messages)
        }
    }
    
    func loadMessage(finished: @escaping MessagesClosure) {
        networkLayer.loadMessages()
            .subscribe(onNext: { result, json in
                guard let messagesJson = json as? [[String:Any]] else { return }
                
                print( messagesJson )
                
            }, onError: { error in
                print( error.localizedDescription )
            }).disposed(by: bag)
    }
}
