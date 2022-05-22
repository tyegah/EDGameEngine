//
//  Game.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 22/05/22.
//

import Foundation

// We create this Game class to hold on to the flow and making it not accessible from anywhere, keeping it internal
public class Game<Question, Answer:Equatable, R:Router> where R.Question == Question, R.Answer == Answer {
    let flow:Flow<Question, Answer, R>
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer:Equatable, R:Router>(questions:[Question], router: R, correctAnswers:[Question:Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: { scoring($0, correctAnswers: correctAnswers) })
    flow.start() // at this point, the GameTests will crash because the flow is instantiated and removed right away from memory without anything holding it
    // And that is why we should create something that holds the flow variable without exposing it's methods and stuff
    return Game(flow: flow)
}

private func scoring<Question:Hashable, Answer:Equatable>(_ answers:[Question:Answer], correctAnswers:[Question:Answer]) -> Int {
    return answers.reduce(0) { (score, arg1) in
        let (question, answer) = arg1
        return score + (correctAnswers[question] == answer ? 1 : 0)
    }
}
