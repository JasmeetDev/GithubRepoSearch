//
//  AssignmentUITests.swift
//  AssignmentUITests
//
//  Created by Jasmeet Singh on 15/07/21.
//

import XCTest

class AssignmentUITests: XCTestCase {
    let searchButton = XCUIApplication().buttons["SearchButton"]
    let repoCollectionView = XCUIApplication().collectionViews["RepoCollectionView"]
    let segmentControl = XCUIApplication().segmentedControls["SegmentControl"]
    let inputField = XCUIApplication().textFields["InputField"]
    let collectionCell = XCUIApplication().collectionViews.cells["CollectionCell"]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForElementsInListScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssert(searchButton.exists, "Search button is not available")
        XCTAssert(repoCollectionView.exists, "Repo collectionview is not available")
        XCTAssert(segmentControl.exists, "Segment control is not available")
        XCUIApplication().textFields["InputField"].tap()
        XCTAssert(inputField.exists, "Input field is not available")
    }
    
    func testForEmptySearch() throws {
        let app = XCUIApplication()
        app.launch()
        
        searchButton.tap()
        
        let alertExists = app.staticTexts["Please enter text."].waitForExistence(timeout: 1)
        XCTAssertTrue(alertExists)
        
    }

    func testForSearchRepo() throws {
        let app = XCUIApplication()
        app.launch()
        
        
        inputField.tap()
        inputField.typeText("swift")
        
        if app.keys.element(boundBy: 0).exists {
            app.typeText("\n")
            searchButton.tap()
        }
        
        _ = app.waitForExistence(timeout: 2)
        XCTAssertTrue(repoCollectionView.waitForExistence(timeout: 1))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
