import XCTest

class WeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOpenWeatherMaps() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let exp = expectation(description: "Get weather data")
        
        let controller = OpenWeatherMapNetworkController()
        
        let city = "Seattle"
        
        controller.fetchCurrentWeatherData(city: city) { (weatherData, error) in
            XCTAssertNil(error, "fetchWeatherData() call returned error: \(error?.localizedDescription ?? "")")
            if let data = weatherData {
                print("Weather in \(city): \(data.condition), \(data.temperature) \(data.unit)")
                exp.fulfill()
            } else {
                XCTFail("no data returned by fetchWeatherData()")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
