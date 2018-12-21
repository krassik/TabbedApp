import Foundation
import Alamofire

final class OVNetworkController: NetworkController {
   
    func fetchAll(url: String, completionHandler: @escaping ([Any]?) -> Void ) {
        
        Alamofire.request(url).responseJSON { (response) in
            // print( response.value ?? "no info")
            
            guard
               let data = response.data,
               let videos = try? JSONDecoder().decode([Video].self, from: data) else {
            
               completionHandler( nil )
               return
            }
            
            completionHandler( videos )
        }
    }
    
    func fetchCurrentWeatherData(city: String, completionHandler: @escaping (WeatherData?, NetworkControllerError?) -> Void) {
    }
    
}


