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
    let router = RouterSpy()
    
    // Think of the most basic thing, like when the game starts and there is no questions available
    // How it would behave
    // In this case the flow would go straight to the result presentation
    // or whoever is responsible for the presentation logic
    // in this case, the router will be responsible for routing the result
    // In this stage, we also don't know what the result would look like
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
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
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // After the first correct question routed, we need to check if a different question will still give the correct result
    func test_start_oneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    
    // After we successfully test the router results for only one question,
    // now we need to test with two questions and see if it will route correctly to the first question
    func test_start_twoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // If the router is being started twice, the question routed should also be the same twice
    func test_startTwice_twoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    // Here we need to test if the Flow with two questions is started, routed to the 1st question and answered, it will route to the 2nd question.
    // Because of this, we need a way to capture the answer behavior inside the spy
    // Thus, we're adding answer callback closure on the router protocol
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    // Here we need to test if the Flow with three questions is started, routed to the 1st question and answered, it will route to the 2nd question. And then 2nd question is answered, it will route to the 3rd question.
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    
    // Because previously, we didn't take care of the cases where there's only one question and if it's answered, it shouldn't go anywhere else
    // We need to check if the range of the questions are safely handled
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // MARK: - Helper
    
    // By doing this, we can change the initializer without breaking the tests
    func makeSUT(questions:[String]) -> Flow {
        return Flow(questions:questions, router:router)
    }
    
    // Spy is the object and you just spying or stubbing specific methods of it.
    // While in spy objects, of course, since it is a real method, when you are not stubbing the method, then it will call the real method behavior
    class RouterSpy:Router {
        var routedQuestions:[String] = []
        var answerCallback: Router.AnswerCallback = { _ in }
        func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
