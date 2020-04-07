//
//  videoPlayerUITests.swift
//  videoPlayerUITests
//
//  Created by Çağrı Tuğberk Masat on 7.04.2020.
//  Copyright © 2020 Çağrı Tuğberk Masat. All rights reserved.
//

import XCTest

class videoPlayerUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    func testDummy(){
        
        let app = XCUIApplication()
        app.launch()
        
        let tableQuery = app.tables
        print("Cells' Count -> \(tableQuery.cells.count)")
        tableQuery.cells.element(boundBy: 0).tap()
        sleep(2)
        let timeSlider = app.sliders["timeSlider"]
        
        timeSlider.adjust(toNormalizedSliderPosition: 0.8)
        timeSlider.adjust(toNormalizedSliderPosition: 0.2)
        timeSlider.adjust(toNormalizedSliderPosition: 0.5)
        app.buttons["Play"].tap()
        sleep(1)
        app.navigationBars["videoPlayer.View"].buttons["Back"].tap()
        sleep(1)
        tableQuery.cells.element(boundBy: 1).tap()
        sleep(1)
        app.buttons["Play"].tap()
        sleep(5)
    }
    
    func testVideoPlayer() {
        let app = XCUIApplication()
        app.launch()
        
        let tableQuery = app.tables
        tableQuery.staticTexts["Video2"].tap()
        app.navigationBars["videoPlayer.View"].buttons["Back"].tap()
        tableQuery.staticTexts["Video3"].tap()
        let playButton = app.buttons["Play"]
        playButton.tap()
        let forwardButton = app.buttons[">>"]
        let backwardButton = app.buttons["<<"]
        forwardButton.tap()
        backwardButton.tap()
    }
    
    func testViewTableDataExist() {
        let app = XCUIApplication()
        app.launch()
        let tableQuery = app.tables
        XCTAssertTrue(tableQuery.staticTexts["Video2"].exists, "Sample Message for Video2")
        XCTAssertTrue(tableQuery.staticTexts["Video3"].exists, "Sample Message for Video3")
    }
    
    func testCellVisitor() {
        let app = XCUIApplication()
        app.launch()
        
        let tableQuery = app.tables
        let countOfCells = tableQuery.cells.count
        let timeSlider = app.sliders["timeSlider"]
        var i = 0
        //For all cells ...
        while i < countOfCells {
            
            XCTAssertTrue(tableQuery.cells.count > 0, "Cell count error")
            tableQuery.cells.element(boundBy: i).tap()
            sleep(1)
            app.buttons["Play"].tap()
            sleep(5)
            app.buttons["Pause"].tap()
            sleep(1)
            timeSlider.adjust(toNormalizedSliderPosition: 0.8)
            timeSlider.adjust(toNormalizedSliderPosition: 0.2)
            app.navigationBars["videoPlayer.View"].buttons["Back"].tap()
            sleep(1)
            i += 1
        }
    }
}



