//
//  RouterSpy.swift
//  EDGameEngineTests
//
//  Created by Ty Septiani on 22/05/22.
//

@testable import EDGameEngine

// Spy is the object and you just spying or stubbing specific methods of it.
// While in spy objects, of course, since it is a real method, when you are not stubbing the method, then it will call the real method behavior
class RouterSpy:Router {
    var routedQuestions:[String] = []
    var answerCallback: (String) -> Void = { _ in }
    var routedResult:Result<String,String>? = nil
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Result<String,String>) {
        self.routedResult = result
    }
}
