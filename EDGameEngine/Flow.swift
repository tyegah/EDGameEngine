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
    typealias AnswerCallback = (String) -> Void
    func routeTo(question:String, answerCallback: @escaping AnswerCallback)
    func routeTo(result:[String:String])
}
// we make this as a class because it has a behaviour and not just values
class Flow {
    private let router:Router
    private let questions:[String]
    private var result:[String:String] = [:]
    init(questions: [String], router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        }
        else {
            router.routeTo(result: result)
        }
    }
    
    private func routeNext(from question:String) -> Router.AnswerCallback {
        return {[weak self] answer in
            guard let self = self else {return}
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                self.result[question] = answer
                if currentQuestionIndex+1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex+1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
                }
                else {
                    self.router.routeTo(result: self.result)
                }
            }
        }
    }
}
