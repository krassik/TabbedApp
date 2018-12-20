import Foundation


public protocol NetworkController {
    func fetchCurrentWeatherData(city: String, completionHandler: @escaping (WeatherData?, NetworkControllerError?) -> Void)
    
    func fetchAll(url: String, completionHandler: @escaping ([Any]?) -> Void)
}


public struct WeatherData {
    let temperature: Float
    let condition: String
    let unit: TemperatureUnit
}


public enum TemperatureUnit: String {
    case scientific = "scientific"
    case metric = "metric"
    case imperial = "imperial"
}

public enum NetworkControllerError:  Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}
