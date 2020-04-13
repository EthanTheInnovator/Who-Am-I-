//
//  PhantomTheif.swift
//  Who Am I
//
//  Created by Ethan Humphrey on 10/22/19.
//  Copyright © 2019 Ethan Humphrey. All rights reserved.
//

import Foundation

struct PhantomTheif: Equatable {
    var imageName: String!
    var characterName: String!
    var characterDescription: String!
    
    init(_ characterName: String, characterDescription: String, imageName: String) {
        self.characterName = characterName
        self.characterDescription = characterDescription
        self.imageName = imageName
    }
    
    static func getTheif(_ type: PhantomTheifType) -> PhantomTheif {
        switch type {
        case .joker:
            return PhantomTheif("Joker", characterDescription: "The silent protagonist. You're best all around. You are a great leader that inspires others and never has a hard time making friends.", imageName: "joker")
        case .mona:
            return PhantomTheif("Morgana/Mona", characterDescription: "You're playful and fun to be around. You may be quick to get annoyed, but you're so lovable that others don't really care. You love sushi and tuna, and for some reason you go to bed really early...", imageName: "morgana")
        case .skull:
            return PhantomTheif("Ryuji Sakamoto/Skull", characterDescription: "You're a bit hotheaded and quick to anger. You love sports and anything that gives you adrenaline. You constantly think about fame and getting others to like you, but deep down you're a great friend.", imageName: "skull")
        case .panther:
            return PhantomTheif("Ann Takamaki/Panther", characterDescription: "Your looks define you. Too many people get caught up in how you look to see through to the warm-hearted person you truely are. You look up to some of the biggest celebrities as your idols.", imageName: "panther")
        case .fox:
            return PhantomTheif("Yusuke Kitagawa/Fox", characterDescription: "You find you are most comfortable with a paintbrush in hand. You see the beauty in everything and want to capture it with your brush. You are truely passionate about everything you do.", imageName: "fox")
        case .queen:
            return PhantomTheif("Makoto Nijima/Queen", characterDescription: "You're a straight A student with enough wits to get you places in life. You could go to any top university just through your smarts and putting in a bit of effort. Don't let that decieve anyone, however, because you can take control of any situation in an instant.", imageName: "queen")
        case .oracle:
            return PhantomTheif("Futaba Sakura/Oracle", characterDescription: "You're a real gamer/programmer. You spend your nights sitting in front of a computer eating chips and drinking soda while simultaneously watching anime and playing video games. You built your own computer and love to show it off to others, and probably even built the OS it runs on. Other people may scare you, but once you let someone in you'll never let them go.", imageName: "oracle")
        case .noir:
            return PhantomTheif("Haru Okumura/Noir", characterDescription: "You're an outdoorsman. The wind, trees, sky, and flowers all make you feel at home. You love to garden and you grow your own vegetables. You're also sweet to everyone and fun to be around.", imageName: "noir")
        case .crow:
            return PhantomTheif("Goro Akechi/Crow", characterDescription: "Your fame proceeds you. You've accomplished so much in so little time. Everyone seems to gawk at you, but you just want some real friends that will be by your side. You are always calm and collected, seemingly having a plan behind everything you do.", imageName: "crow")
        }
    }
    
    static func calculateFinalCharacter(_ resultsArray: [PhantomTheifType]) -> PhantomTheif {
        var countsArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for i in 0 ..< resultsArray.count {
            countsArray[resultsArray[i].rawValue] += 1
        }
        var maxIndex = 0
        for i in 0 ..< countsArray.count {
            if countsArray[i] >= countsArray[maxIndex] {
                maxIndex = i
            }
        }
        print(countsArray)
        let type = PhantomTheifType(rawValue: maxIndex) ?? .joker
        return getTheif(type)
    }
    
    enum PhantomTheifType: Int {
        case joker
        case mona
        case skull
        case panther
        case fox
        case queen
        case oracle
        case noir
        case crow
    }
}
