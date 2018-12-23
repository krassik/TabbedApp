import Foundation
import Alamofire

class TVNetworkController {
    func fetch(url: String, completionHandler: @escaping (Any?) -> Void ) {
        Alamofire.request(url).responseJSON { (response) in
            // print( response.value ?? "no info")
            
            guard
                let data = response.data,
                let items = try? JSONDecoder().decode([Item].self, from: data) else {
                    
                    completionHandler( nil )
                    return
            }
            
            completionHandler( items )
        }
    }
}
