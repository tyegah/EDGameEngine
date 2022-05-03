//
//  FlowTests.swift
//  EDGameEngineTests
//
//  Created by Ty Septiani on 29/04/22.
//

import Foundation
import XCTest
@testable import EDGameEngine

class FlowTests:XCTestCase {
    // Think of the most basic thing, like when the game starts and there is no questions available
    // How it would behave
    // In this case the flow would go straight to the result presentation
    // or whoever is responsible for the presentation logic
    // in this case, the router will be responsible for routing the result
    // In this stage, we also don't know what the result would look like
    func test_start_withNoQuestions_() {
        let router = RouterSpy()
        let sut = Flow(router:router)
        sut.start()
        XCTAssertEqual(router.routedQuestionsCount, 0)
    }
    
    // Spy is the object and you just spying or stubbing specific methods of it.
    // While in spy objects, of course, since it is a real method, when you are not stubbing the method, then it will call the real method behavior
    class RouterSpy:Router {
        var routedQuestionsCount:Int = 0
    }
}
