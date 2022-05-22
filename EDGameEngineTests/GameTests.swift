//
//  GameTests.swift
//  EDGameEngineTests
//
//  Created by Ty Septiani on 22/05/22.
//

import XCTest
import EDGameEngine // We dont need @testable because we want to make it public for the integration test

class GameTests:XCTestCase {
    // We move the game and router objects here to make sure they hold strong references in the test
    var router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    // Here we want to start testing if the game scoring function is running correctly,
    // and we start out by calculating two questions with one answer correct
    // we simulate the startGame function and also simulate the answer with router answercallback
    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        let router = RouterSpy()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1":"A1", "Q2":"A2"])
        router.answerCallback("A1")
        router.answerCallback("wrong answer")
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    // Because we hardcoded the score on the first test, we add another test to check for the scoring function
    // In this stage, we will create the scoring method to really calculate the score
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        let router = RouterSpy()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1":"A1", "Q2":"A2"])
        router.answerCallback("wrong answer")
        router.answerCallback("wrong answer")
        XCTAssertEqual(router.routedResult!.score, 0)
    }
}
