//
//  SKCountdownLabelExampleTests.swift
//  SKCountdownLabelExampleTests
//
//  Created by 鈴木 啓司 on 2016/01/08.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import XCTest
import SKCountdownLabel
@testable import SKCountdownLabelExample

class SKCountdownLabelExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithCoder() {
        let storyboard = UIStoryboard(name: "StoryboardTests", bundle: NSBundle(forClass: self.dynamicType))
        let vc = storyboard.instantiateInitialViewController()
        XCTAssertNotNil(vc)
        XCTAssertEqual(vc?.view.subviews.count, 3)
    }
    
    func testInitWithFrame() {
        let l = SKCountdownLabel()
        XCTAssertNotNil(l)
    }

    func testStartStatus() {
        let label = SKCountdownLabel()
        
        label.setCountDownTime(30)
        label.start()
        
        XCTAssertEqual(label.counting, true)
        XCTAssertEqual(label.paused, false)
        XCTAssertEqual(label.timeFormat, "HH:mm:ss")
    }
    
    func testPauseStatus() {
        let label = SKCountdownLabel()
        
        label.setCountDownTime(30)
        label.start()
        label.pause()
        
        XCTAssertEqual(label.counting, false)
        XCTAssertEqual(label.paused, true)
        XCTAssertEqual(label.finished, false)
        XCTAssertEqual(label.timeCounted.int, 0)
        XCTAssertEqual(label.timeRemaining.int, 30)
    }
    
    func testAfterASecond() {
        let label = SKCountdownLabel()
        
        label.setCountDownTime(30)
        label.start()
        
        let expectation = expectationWithDescription("refreshed")
        delay(1.0){
            label.pause()
            
            XCTAssertEqual(label.counting, false)
            XCTAssertEqual(label.paused, true)
            XCTAssertEqual(label.finished, false)
            XCTAssertEqual(label.timeCounted.int, 1)
            XCTAssertEqual(label.timeRemaining.int, 29)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2.0, handler: nil)
    }
    
    func testCountdownFinished() {
        let label = SKCountdownLabel()
        
        label.setCountDownTime(1)
        label.start()
        
        let expectation = expectationWithDescription("refreshed")
        delay(1.1){
            
            XCTAssertEqual(label.finished, true)
            XCTAssertEqual(label.counting, false)
            XCTAssertEqual(label.paused, false)
            XCTAssertEqual(label.timeCounted.int, 1)
            XCTAssertEqual(label.timeRemaining.int, 0)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func dateFrom(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> NSDate {
        let string = String(format: "%d-%02d-%dT%d:%02d:28+0900", year, month, day, hour, minute)
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.dateFromString(string)!
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}