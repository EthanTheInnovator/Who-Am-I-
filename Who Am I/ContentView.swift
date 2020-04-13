//
//  ContentView.swift
//  Who Am I
//
//  Created by Ethan Humphrey on 10/18/19.
//  Copyright © 2019 Ethan Humphrey. All rights reserved.
//

/*
 
 For my "Who am I?" app, I based it on my favorite video game "Persona 5"
 
 You can get any of the 9 main characters
 
 I built the app to be ultra modular, so writing and changing questions is just a matter of knowing what you want the questions to be (try it out by editing Question.swift).
 The different UI elements I used were switches, pickers, and steppers (in addition to buttons)
 I also added a blur view and finally figured out animations in SwiftUI!!!
 
 Bugs:
 - I couldn't figure out how to go back to a question without the animation glitching out
 - If you hit next while the animation is still playing, it'll go back to the last question, but act like it's at the next question (it's weird)
 - The pickers can only be edited on an actual device, so a simulator does not work (not sure why, I think this is a bug in Xcode, come ask me if you need to use my phone).
 - If there's a tie, it automatically goes to the last match
 - There's one page where the text cuts off. This is a bug in SwiftUI that I was able to fix for most of the labels but for that one I couldn't
 
 */

import SwiftUI
import SwiftUIBlurView

let widthPercent: CGFloat = 0.7
let allQuestions = Question.getPhantomTheifQuestions()

extension AnyTransition {
    static var invertedSlide: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading)
        .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct ContentView: View {
    
    @State var resultsArray = [PhantomTheif.PhantomTheifType]()
    @State var currentQuestionIndex: Int = 0
    @State var isGoingBackwards: Bool = false
    @State var finalCharacter: PhantomTheif? = nil
    
    var body: some View {
        NavigationView {
            GeometryReader { metrics in
                ZStack {
                    Image("background")
                    if self.finalCharacter == nil {
                        VStack {
                            if self.currentQuestionIndex % 2 == 0 {
                                HStack {
                                    Spacer()
                                    QuestionView(resultsArray: self.$resultsArray, currentQuestionIndex: self.$currentQuestionIndex, isGoingBackwards: self.$isGoingBackwards, finalCharacter: self.$finalCharacter, myQuestionIndex: self.currentQuestionIndex, metrics: metrics)
                                    Spacer()
                                }
                                .animation(.spring())
                                .transition(self.isGoingBackwards ? .slide : .invertedSlide)
                            }
                            else {
                                HStack {
                                    Spacer()
                                    QuestionView(resultsArray: self.$resultsArray, currentQuestionIndex: self.$currentQuestionIndex, isGoingBackwards: self.$isGoingBackwards, finalCharacter: self.$finalCharacter, myQuestionIndex: self.currentQuestionIndex, metrics: metrics)
                                    Spacer()
                                }
                                .animation(.spring())
                                .transition(self.isGoingBackwards ? .slide : .invertedSlide)
                            }
                        }
                        .animation(.spring())
                        .transition(.invertedSlide)
                    }
                    else {
                        VStack {
                            Text("You are:   ")
                                .padding(.horizontal, 8)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                            Text("\(self.finalCharacter?.characterName ?? "")      ")
                                .padding(.horizontal, 8)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                            Image(self.finalCharacter?.imageName ?? "")
                                .resizable()
                                .scaledToFit()
                                .frame(width: nil, height: 200, alignment: .center)
                            Text(self.finalCharacter?.characterDescription ?? "")
                                .padding(.horizontal, 8)
                                .multilineTextAlignment(.leading)
                                .lineLimit(20)
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.resultsArray = []
                                    self.currentQuestionIndex = 0
                                    self.isGoingBackwards = false
                                    self.finalCharacter = nil
                                }) {
                                    Text("Restart")
                                    .padding()
                                }
                                .accentColor(Color(.systemRed))
                                Spacer()
                            }
                        }
                        .frame(width: metrics.size.width*widthPercent, height: nil, alignment: .center)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 16)
                        .background(BlurView(style: .systemMaterial))
                        .cornerRadius(30)
                        .animation(.spring())
                        .transition(.invertedSlide)
                    }
                }
            }
        }
    }
}

struct QuestionView: View {
    @Binding var resultsArray: [PhantomTheif.PhantomTheifType]
    @Binding var currentQuestionIndex: Int
    @Binding var isGoingBackwards: Bool
    @Binding var finalCharacter: PhantomTheif?
    @State var myQuestionIndex: Int = 0
    @State var metrics: GeometryProxy!
    @State var stepperNums: [Int] = [3, 3, 3, 3, 3]
    @State var switchValues: [Bool] = [false, false, false, false, false]
    @State var selectionIndex: Int = -1
    
    var body: some View {
        VStack {
            Text(allQuestions[self.myQuestionIndex].text)
                .padding(.horizontal, 8)
                .padding(.vertical, 30)
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(5)
            if allQuestions[self.myQuestionIndex].type == .multipleChoice {
                MultipleChoiceView(answers: allQuestions[self.myQuestionIndex].answers, metrics: metrics, selectionIndex: self.$selectionIndex)
            }
            else if allQuestions[self.myQuestionIndex].type == .stepperChoice {
                StepperView(answers: allQuestions[self.myQuestionIndex].answers, stepperNums: self.$stepperNums)
            }
            else if allQuestions[self.myQuestionIndex].type == .switchChoice {
                SwitchView(answers: allQuestions[self.myQuestionIndex].answers, switchValues: self.$switchValues)
            }
            else if allQuestions[self.myQuestionIndex].type == .pickerChoice {
                PickerView(answers: allQuestions[self.myQuestionIndex].answers, metrics: metrics, currentPickerIndex: self.$selectionIndex)
            }
            Divider()
            HStack {
//                Button(action: {
//                    self.isGoingBackwards = true
//                    self.currentQuestionIndex -= 1
//                }) {
//                    Text("Back")
//                }
//                .disabled(self.myQuestionIndex <= 0)
                Spacer()
                Button(action: {
                    self.isGoingBackwards = false
                    switch allQuestions[self.myQuestionIndex].type {
                    case .multipleChoice, .pickerChoice:
                        self.resultsArray.append(contentsOf: allQuestions[self.myQuestionIndex].answers[self.selectionIndex].correlationToPerson)
                    case .stepperChoice:
                        for i in 0 ..< allQuestions[self.myQuestionIndex].answers.count {
                            self.resultsArray.append(allQuestions[self.myQuestionIndex].answers[i].correlationToPerson[self.stepperNums[i] - 1])
                        }
                    case .switchChoice:
                        for i in 0 ..< allQuestions[self.myQuestionIndex].answers.count {
                            if self.switchValues[i] {
                                self.resultsArray.append(contentsOf: allQuestions[self.myQuestionIndex].answers[i].correlationToPerson)
                            }
                        }
                    case .none:
                        break
                    }
                    print(self.resultsArray)
                    if self.currentQuestionIndex != allQuestions.count - 1 {
                        self.currentQuestionIndex += 1
                    }
                    else {
                        self.finalCharacter = PhantomTheif.calculateFinalCharacter(self.resultsArray)
                    }
                }) {
                    Text(self.myQuestionIndex >= allQuestions.count - 1 ? "Get Results" : "Next")
                }
                .disabled((allQuestions[self.myQuestionIndex].type == .multipleChoice || allQuestions[self.myQuestionIndex].type == .pickerChoice) && selectionIndex == -1)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .accentColor(Color(.systemRed))
        }
        .frame(width: metrics.size.width*widthPercent, height: nil, alignment: .center)
        .padding(.horizontal, 8)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(30)
        .transition(.slide)
    }
}

struct MultipleChoiceView: View {
    @State var answers: [Answer] = []
    @State var metrics: GeometryProxy!
    @Binding var selectionIndex: Int
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ForEach(0 ..< answers.count) { answerIndex in
                Divider()
                Button(action: {
                    self.selectionIndex = answerIndex
                }) {
                    Text(self.answers[answerIndex].text)
                        .frame(width: self.metrics.size.width*widthPercent*0.85, height: nil, alignment: .center)
                        .padding(8)
                        .background(self.selectionIndex == answerIndex ? Color(.systemGray) : Color(.systemRed))
                        .disabled(self.selectionIndex == answerIndex)
                        .animation(.spring())
                        .foregroundColor(Color(.white))
                        .cornerRadius(15)
                        .padding(.horizontal, 8)
                }
            }
        }
    }
}

struct StepperView: View {
    @State var answers: [Answer] = []
    @Binding var stepperNums: [Int]
    var body: some View {
        VStack {
            ForEach(0 ..< answers.count) { answerIndex in
                Divider()
                Stepper("\(self.answers[answerIndex].text): \(self.stepperNums[answerIndex])   ", value: self.$stepperNums[answerIndex], in: self.answers[answerIndex].stepperRange)
                .padding()
            }
        }
    }
}

struct SwitchView: View {
    @State var answers: [Answer] = []
    @Binding var switchValues: [Bool]
    var body: some View {
        VStack {
            ForEach(0 ..< answers.count) { answerIndex in
                Divider()
                HStack{
                    Text(self.answers[answerIndex].text)
                        .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    Toggle(isOn: self.$switchValues[answerIndex]) {
                        Text("")
                    }
                }
                .padding()
            }
        }
    }
}

struct PickerView: View {
    @State var answers: [Answer] = []
    @State var metrics: GeometryProxy!
    @Binding var currentPickerIndex: Int
    var body: some View {
        VStack {
            Divider()
            Picker(selection: $currentPickerIndex, label: Text("")) {
                ForEach(0 ..< answers.count) {
                    Text(self.answers[$0].text).tag($0)
                }
            }
            .frame(width: metrics.size.width*widthPercent, height: nil, alignment: .center)
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
//            .environment(\.colorScheme, .dark)
        ContentView(resultsArray: [], currentQuestionIndex: 0, isGoingBackwards: false, finalCharacter: PhantomTheif.getTheif(.crow))
        .environment(\.colorScheme, .dark)
    }
}
