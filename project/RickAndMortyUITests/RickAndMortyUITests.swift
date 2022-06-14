//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Marina Roshchupkina on 12.06.2022.
//

import XCTest

class RickAndMortyUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchAndFavs() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["search"].tap()
        app/*@START_MENU_TOKEN@*/.keys["R"]/*[[".keyboards.keys[\"R\"]",".keys[\"R\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let kKey = app/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        kKey.tap()
        
        let rickSanchezStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Rick Sanchez"]/*[[".cells.staticTexts[\"Rick Sanchez\"]",".staticTexts[\"Rick Sanchez\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rickSanchezStaticText.tap()
        app.scrollViews.otherElements.images["love"].tap()
        sleep(1)
        app.navigationBars["Character"].buttons["Back"].tap()
        app.tabBars["Tab Bar"].buttons["love"].tap()
        rickSanchezStaticText.tap()
        app.scrollViews.otherElements.images["love"].tap()
    }
    
    func testSearchAndHistory() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["search"].tap()
        
        let mKey = app.keys["M"]
        mKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let rKey = app.keys["r"]
        rKey.tap()
        
        let tKey = app.keys["t"]
        tKey.tap()
        
        let yKey = app/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yKey.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Morty Smith"]/*[[".cells.staticTexts[\"Morty Smith\"]",".staticTexts[\"Morty Smith\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let backButton = app.navigationBars["Character"].buttons["Back"]
        backButton.tap()
        sleep(1)
        tablesQuery/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element.tap()
        backButton.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
