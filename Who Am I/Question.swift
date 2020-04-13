//
//  Question.swift
//  Who Am I
//
//  Created by Ethan Humphrey on 10/18/19.
//  Copyright © 2019 Ethan Humphrey. All rights reserved.
//

import Foundation

struct Question {
    var text: String!
    var answers: [Answer]!
    var type: QuestionType!
    
    init(_ text: String, answers: [Answer], type: QuestionType) {
        self.text = text
        self.answers = answers
        self.type = type
    }
    
    enum QuestionType {
        case multipleChoice
        case stepperChoice
        case switchChoice
        case pickerChoice
    }
    
    static func getPhantomTheifQuestions() -> [Question] {
        return [
            Question("What is your favorite color?", answers: [
                Answer("Red", correlations: [.joker, .panther, .crow]),
                Answer("Orange", correlations: [.oracle]),
                Answer("Yellow", correlations: [.skull]),
                Answer("Green", correlations: [.oracle]),
                Answer("Blue", correlations: [.fox]),
                Answer("Purple", correlations: [.noir]),
                Answer("Pink", correlations: [.panther, .noir]),
                Answer("Black", correlations: [.mona, .crow, .joker]),
                Answer("White", correlations: [.crow, .fox])
            ], type: .pickerChoice),
            Question("What is your favorite element?", answers: [
                Answer("Fire", correlations: [.panther]),
                Answer("Electricity", correlations: [.skull]),
                Answer("Ice", correlations: [.fox]),
                Answer("Wind", correlations: [.mona]),
                Answer("All", correlations: [.joker])
            ], type: .multipleChoice),
            Question("Which of the following statements do you agree with?", answers: [
                Answer("I care for others more than I care about myself", correlations: [.mona, .queen]),
                Answer("I'd love to be adored by others", correlations: [.skull]),
                Answer("I'm a naturally born leader", correlations: [.joker]),
                Answer("I love the outdoors", correlations: [.noir, .mona])
            ], type: .switchChoice),
            Question("On a scale of one to five, how much do you like the following?", answers: [
                Answer("Painting", correlations: [.oracle, .skull, .joker, .noir, .fox]),
                Answer("Gaming", correlations: [.fox, .noir, .joker, .skull, .oracle]),
                Answer("Modeling", correlations: [.queen, .mona, .joker, .crow, .panther]),
                Answer("Politics", correlations: [.skull, .oracle, .joker, .noir, .crow]),
                Answer("Sports", correlations: [.oracle, .queen, .joker, .panther, .skull])
            ], type: .stepperChoice),
            Question("Where is your go-to hang out spot?", answers: [
                Answer("My house", correlations: [.oracle, .mona, .joker]),
                Answer("Restaurant", correlations: [.skull, .noir, .mona, .queen]),
                Answer("Roller Coasters!", correlations: [.panther, .skull]),
                Answer("Museum", correlations: [.fox, .panther, .crow, .queen]),
                Answer("Tech Store", correlations: [.oracle])
            ], type: .multipleChoice),
            Question("What do you want to do for a living?", answers: [
                Answer("Lawyer/Detective", correlations: [.queen, .crow]),
                Answer("Artist", correlations: [.fox]),
                Answer("Be a Celebrity", correlations: [.crow, .panther]),
                Answer("Sports Superstar", correlations: [.skull]),
                Answer("Programmer", correlations: [.oracle]),
                Answer("Run a corporation", correlations: [.joker, .noir])
            ], type: .pickerChoice),
            Question("What type of movies do you like?", answers: [
                Answer("Action/Adventure", correlations: [.crow, .skull, .queen]),
                Answer("Horror", correlations: [.noir, .joker]),
                Answer("RomComs", correlations: [.panther, .fox]),
                Answer("Comedies", correlations: [.mona, .joker])
            ], type: .multipleChoice),
            Question("What is your favorite subject?", answers: [
                Answer("Math", correlations: [.queen]),
                Answer("Art", correlations: [.fox, .noir, .panther]),
                Answer("PE", correlations: [.skull, .mona]),
                Answer("History", correlations: [.queen]),
                Answer("Forensics", correlations: [.crow])
            ], type: .multipleChoice),
            Question("Which of the following qualities describes you?   ", answers: [
                Answer("Hot", correlations: [.panther]),
                Answer("Loyal", correlations: [.mona, .skull]),
                Answer("Smart", correlations: [.queen]),
                Answer("Creative", correlations: [.noir, .fox]),
                Answer("Intuitive", correlations: [.crow])
            ], type: .switchChoice),
            Question("What is your favorite type of food?", answers: [
                Answer("Lobster", correlations: [.fox]),
                Answer("Burgers", correlations: [.noir, .joker]),
                Answer("Ramen", correlations: [.skull, .oracle]),
                Answer("Cake", correlations: [.panther]),
                Answer("Pancakes", correlations: [.crow]),
                Answer("Sushi", correlations: [.mona])
            ], type: .pickerChoice)
        ]
    }
}

struct Answer: Identifiable {
    var id = UUID()
    var stepperRange: ClosedRange<Int> = 1 ... 5
    var text: String!
    var correlationToPerson: [PhantomTheif.PhantomTheifType] = []
    
    init(_ answer: String, correlations: [PhantomTheif.PhantomTheifType]) {
        text = answer
        correlationToPerson = correlations
    }
}
