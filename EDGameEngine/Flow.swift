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
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        }
        else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallback(from question:String) -> Router.AnswerCallback {
        return {[weak self] answer in
            if let self = self {
                self.routeNext(question, answer)
            }
        }
    }
    
    private func routeNext(_ question:String,_ answer:String) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex+1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            }
            else {
                router.routeTo(result: result)
            }
        }
    }
}
