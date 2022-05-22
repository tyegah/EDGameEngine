//
//  GameTests.swift
//  EDGameEngineTests
//
//  Created by Ty Septiani on 22/05/22.
//

import XCTest
@testable import EDGameEngine

class GameTests:XCTestCase {
    // Here we want to start testing if the game scoring function is running correctly,
    // and we start out by calculating two questions with one answer correct
    // we simulate the startGame function and also simulate the answer with router answercallback
    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        let router = RouterSpy()
        startGame(questions: ["Q1", "Q2"], router: router, answers: ["Q1":"A1", "Q2":"A2"])
        router.answerCallback("A1")
        router.answerCallback("wrong answer")
        XCTAssertEqual(router.routedResult!.score, 1)
    }
}
