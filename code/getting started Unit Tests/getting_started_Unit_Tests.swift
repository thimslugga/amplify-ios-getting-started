//
//  getting_started_Unit_Tests.swift
//  getting started Unit Tests
//
//  Created by Stormacq, Sebastien on 29/09/2021.
//  Copyright © 2021 Stormacq, Sebastien. All rights reserved.
//

import XCTest
@testable import getting_started

class getting_started_Unit_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNote() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let userData = UserData.shared

        //this is just for a demo. Test is not really pertinent as it just tests swift array's append
        let note1 = Note(id: "000", name: "Seb's note", description: "My description", image: "s3 image")
        userData.notes.append(note1)
        
        XCTAssert(userData.notes.count == 1, "Wrong number of notes in the array")

        let note2 = Note(id: "001", name: "Seb's note", description: "My description", image: "s3 image")
        userData.notes.append(note2)
        
        XCTAssert(userData.notes.count == 2, "Wrong number of notes in the array")

    }
    
    func testLoadImage() throws {
        
        // test async load of images
        
        // image name is available after an upload in the app
        // check file name with the following command (bucket and directory name will vary)
        // aws s3 ls s3://iosgettingstarted4f3db8751da949bcafd5e61f192c31123138-dev/private/eu-central-1:842e29fa-c30f-45ec-93fd-cbe9968b6878/
        let note1 = Note(id: "000", name: "Seb's note", description: "My description", image: "B697C492-7557-4639-94A8-9764AEF17012")
        
        // access the underlying NoteData object
        let data = note1.data
        
        // Create an expectation
        let expectation = self.expectation(description: "Download image")

        // create a note with a NoteData object -> this trigger the download of the image
        let note2 = Note(from: data) { image -> Void in
            if let _ = image {
                expectation.fulfill()
            } else {
                XCTFail("Image downloaded is nil")
            }
        }
        
        // Wait for the expectation to be fullfilled, or time out
        // after 5 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssert(note2.image != nil)

    
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}