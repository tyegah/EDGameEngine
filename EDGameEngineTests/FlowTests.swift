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
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions:[], router:router)
        sut.start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    // Because we need a question here, we can start injecting the question into the Flow
//    func test_start_oneQuestion_routesToQuestion() {
//        let router = RouterSpy()
//        let sut = Flow(questions:["Q1"], router:router)
//        sut.start()
//        XCTAssertEqual(router.routedQuestions, ["Q1"])
//    }
//
    // After the routing is successful on the 2nd test, we need to check if the routing gives the correct answer
    func test_start_oneQuestion_routesToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions:["Q1"], router:router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // After the first correct question routed, we need to check if a different question will still give the correct result
    func test_start_oneQuestion_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let sut = Flow(questions:["Q2"], router:router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    
    // After we successfully test the router results for only one question,
    // now we need to test with two questions and see if it will route correctly to the first question
    func test_start_twoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions:["Q1", "Q2"], router:router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // Spy is the object and you just spying or stubbing specific methods of it.
    // While in spy objects, of course, since it is a real method, when you are not stubbing the method, then it will call the real method behavior
    class RouterSpy:Router {
        var routedQuestions:[String] = []
        func routeTo(question: String) {
            routedQuestions.append(question)
        }
    }
}
