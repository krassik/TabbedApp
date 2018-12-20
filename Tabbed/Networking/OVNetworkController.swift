import Foundation
import Alamofire

final class OVNetworkController: NetworkController {
   
    func fetchAll(url: String, completionHandler: @escaping ([Any]?) -> Void ) {
        
        Alamofire.request(url).responseJSON { (response) in
            // print( response.value ?? "no info")
            
            if let data = response.data,
               let videos = try? JSONDecoder().decode([Video].self, from: data) {
            
               completionHandler(videos)
            }
            
            completionHandler( nil )
        }
    }
    
    func fetchCurrentWeatherData(city: String, completionHandler: @escaping (WeatherData?, NetworkControllerError?) -> Void) {
    }
    
}


