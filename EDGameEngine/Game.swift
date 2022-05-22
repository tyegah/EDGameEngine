//
//  Game.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 22/05/22.
//

import Foundation

// We create this Game class to hold on to the flow and making it not accessible from anywhere, keeping it internal
class Game<Question, Answer:Equatable, R:Router> where R.Question == Question, R.Answer == Answer {
    let flow:Flow<Question, Answer, R>
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer:Equatable, R:Router>(questions:[Question], router: R, answers:[Question:Answer]) where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: { _ in 0})
    flow.start() // at this point, the GameTests will crash because the flow is instantiated and removed right away from memory without anything holding it
    // And that is why we should create something that holds the flow variable without exposing it's methods and stuff
}
