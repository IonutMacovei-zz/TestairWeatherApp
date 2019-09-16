//
//  TestairWeatherAppTests.swift
//  TestairWeatherAppTests
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import XCTest
@testable import TestairWeatherApp

class TestairWeatherAppTests: XCTestCase {
    
    var weatherPresenter: WeatherPresenter!
    var weatherModel: WeatherModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        weatherPresenter = WeatherPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherPresenter = nil
        weatherModel = nil
    }

    func testPresenterModel() {
        weatherModel = WeatherModel(description: "clear sky", temperature: 297.59, dt: 1568549217, name: "Bucharest", icon: Data())
        var weatherPresenterModel = weatherPresenter.model
        weatherPresenterModel = weatherModel
        
        XCTAssertEqual(weatherModel.description, weatherPresenterModel?.description)
        XCTAssertEqual(weatherModel.temperature, weatherPresenterModel?.temperature)
        XCTAssertEqual(weatherModel.dt, weatherPresenterModel?.dt)
        XCTAssertEqual(weatherModel.name, weatherPresenterModel?.name)
        XCTAssertEqual(weatherModel.icon, weatherPresenterModel?.icon)
    }
    
    func testListPresenterModel() {
        let weatherArray = ContextHandler.retrieveData()
        let listWeatherModel = ListWeatherPresenter(weatherModel: weatherArray).weatherModel

        XCTAssertNotNil(weatherArray)
        XCTAssertNotNil(listWeatherModel)
        XCTAssertEqual(weatherArray, listWeatherModel)
    }
    
    func testDataReceivedTrue() {
        let dataExpectation = expectation(description: "Service does stuff and runs the callback closure")
        let city = "Paris"
        weatherPresenter.loadWeatherFor(city: city, completion: { completion in
            XCTAssertTrue(completion)
            dataExpectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDataReceivedFalse() {
        let dataExpectation = expectation(description: "Service does stuff and runs the callback closure")
        let city = "SomeRandomCity"
        weatherPresenter.loadWeatherFor(city: city, completion: { completion in
            XCTAssertFalse(completion)
            dataExpectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

}
