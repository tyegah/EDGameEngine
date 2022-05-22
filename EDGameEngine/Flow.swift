//
//  Flow.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 29/04/22.
//

import Foundation

// This router is responsible for routing/navigating between questions
// For example, if it's storyboards, we can implement it in StoryboardRouter,
// if it's navigation controller, it can be NavigationControllerRouter
protocol Router {
    associatedtype Answer // we make the answer and question to be associatedtype to support any type of answer and question.
    associatedtype Question:Hashable // Question needs to be hashable because it will be dictionary
//    typealias AnswerCallback = (String) -> Void // Because the callback will cause the compiler error, we revert it back to just plain closure
    func routeTo(question:Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result:Result<Question,Answer>)
}
// we make this as a class because it has a behaviour and not just values
class Flow <Question, Answer, R:Router> where R.Question == Question, R.Answer == Answer // this is needed to make the Router type different from answer and question
{
    private let router:R
    private let questions:[Question]
    private var result:[Question:Answer] = [:]
    init(questions: [Question], router:R) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        }
        else {
            router.routeTo(result: Result(answers: result))
        }
    }
    
    private func nextCallback(from question:Question) -> (Answer) -> Void {
        return {[weak self] answer in
            if let self = self {
                self.routeNext(question, answer)
            }
        }
    }
    
    private func routeNext(_ question:Question,_ answer:Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex+1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            }
            else {
                router.routeTo(result: Result(answers: result))
            }
        }
    }
}


// Because we need to have the score when we're routing
// We decided to create a data structure like a struct to prevent the
// test from failing and to make things easier

struct Result<Question:Hashable, Answer> {
    // At first we create this first to change the router's protocol "routeTo" with the struct Result
    let answers:[Question:Answer]
}


// Here the question is either plain list or dictionary
//public func startGame<Question:Hashable, Answer:Equatable, R:Router>(questions:[Question], router:R, correctAnswers:[Question:Answer]) {
//
//}
