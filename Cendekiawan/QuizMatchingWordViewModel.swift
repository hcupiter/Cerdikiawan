//
//  QuizMatchingWordViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import Foundation

class QuizMatchingWordViewModel: ObservableObject {
    @Published var leftSelectedChoiceId: Int = -1
//    @Published var leftSelectedFrom: Bool = false
    @Published var rightSelectedChoiceId: Int = -1
//    @Published var rightSelectedFrom: Bool = false
    
//    @Published var listOfCorrectId: [Int] = []
    
    @Published var connectedChoiceId: [(left: Int, right: Int)] = []
    
    @Published var quizConnect: QuizConnect? = nil
    
    func deleteLine(choiceId: Int, selectedFrom: String) {
        if selectedFrom == "Left" {
            print("[DEBUG] Delete connection: [\(connectedChoiceId.contains(where: {$0.left == choiceId}))]")
            connectedChoiceId.removeAll(where: {$0.left == choiceId})
            print("[DEBUG] All available Connection: \(connectedChoiceId)")
        } else if selectedFrom == "Right" {
            print("[DEBUG] Delete connection: [\(connectedChoiceId.contains(where: {$0.right == choiceId}))]")
            connectedChoiceId.removeAll(where: {$0.right == choiceId})
            print("[DEBUG] All available Connection: \(connectedChoiceId)")
        }
    }
    
    func checkDeletion(choiceId: Int, selectedFrom: String) {
        if selectedFrom == "Left" {
            connectedChoiceId.removeAll(where: { $0.left == choiceId })
            resetVariables()
        } else if selectedFrom == "Right" {
            connectedChoiceId.removeAll(where: { $0.right == choiceId })
            resetVariables()
        }
    }
    
    func deselectChoice(choiceId: Int, selectedFrom: String) {
        if selectedFrom == "Left" && choiceId == leftSelectedChoiceId {
            leftSelectedChoiceId = -1
        } else if selectedFrom == "Right" && choiceId == rightSelectedChoiceId {
            rightSelectedChoiceId = -1
        }
    }
    
    func selectChoice(choiceId: Int, selectedFrom: String) {
        if selectedFrom == "Left" && !connectedChoiceId.contains(where: { $0.left == choiceId }) {
            leftSelectedChoiceId = choiceId
        } else if selectedFrom == "Right" && !connectedChoiceId.contains(where: { $0.right == choiceId }) {
            rightSelectedChoiceId = choiceId
        }
    }
    
    func checkConnection() {
        if leftSelectedChoiceId != -1 && rightSelectedChoiceId != -1 {
            if !connectedChoiceId.contains(where: { $0.left == leftSelectedChoiceId }) && !connectedChoiceId.contains(where: { $0.right == rightSelectedChoiceId }){
                //connection are made
                connectedChoiceId.append((left: leftSelectedChoiceId, right: rightSelectedChoiceId))
                //TODO: Draw line
                print("[DEBUG] Connected, all available connection: \(connectedChoiceId)")
                resetVariables()
            }
            
        }
    }
    
    
//    func checkIfChoiceIdTheSame(choiceId: Int, selectedFrom: String){
//        // If user haven't selected any box, set either box to true
//        if !leftSelectedFrom && selectedFrom == "Left" {
//            print("[DEBUG]: LeftID selected: \(leftSelectedChoiceId)")
//            leftSelectedChoiceId = choiceId
//            leftSelectedFrom = true
//        }
//        else if !rightSelectedFrom && selectedFrom == "Right" {
//            print("[DEBUG]: rightID selected: \(rightSelectedChoiceId)")
//            rightSelectedChoiceId = choiceId
//            rightSelectedFrom = true
//        }
//        
//        // if user has selected the left side and click on the right side
//        if selectedFrom == "Right" && leftSelectedFrom {
//            if leftSelectedChoiceId == choiceId {
//                print("[DEBUG]: Right is the correct match from left")
//                listOfCorrectId.append(choiceId)
//            }
//            else {
//                print("[DEBUG]: Right is the incorrect match from left")
//            }
//            resetVariables()
//        }
//        // if user has selected the right side and click on the left side
//        else if selectedFrom == "Left" && rightSelectedFrom {
//            if rightSelectedChoiceId == choiceId {
//                print("[DEBUG]: Left is the correct match from right")
//                listOfCorrectId.append(choiceId)
//            }
//            else {
//                print("[DEBUG]: Left is the incorrect match from right")
//            }
//            resetVariables()
//        }
//    }
    
    func resetVariables(){
        // if ever reach this part of code, regardless what happens, resets all
        leftSelectedChoiceId = -1
//        leftSelectedFrom = false
        rightSelectedChoiceId = -1
//        rightSelectedFrom = false
    }
    
//    func boxShouldActive(choiceID: Int, selectedFrom: String) -> Bool{
//        if selectedFrom == "Left" {
//            if leftSelectedChoiceId == choiceID || listOfCorrectId.contains(choiceID) {
//                return true
//            }
//        }
//        else if selectedFrom == "Right" {
//            if rightSelectedChoiceId == choiceID || listOfCorrectId.contains(choiceID) {
//                return true
//            }
//        }
//        return false
//    }
    
    func boxShouldActive(choiceID: Int, selectedFrom: String) -> Bool{
        if selectedFrom == "Left" {
            if leftSelectedChoiceId == choiceID {
                return true
            }
        }
        else if selectedFrom == "Right" {
            if rightSelectedChoiceId == choiceID {
                return true
            }
        }
        return false
    }
    
    func getQuizConnectFromJSON(){
        self.quizConnect = QuizConnect(
            quizId: 1,
            quizFeedback: Feedback(quizID: 1, feedbackDescription: "You are stupid ah fuck"),
            quizDifficultyLevel: 4,
            quizCategory: "sambung kata",
            quizTitle: "nil",
            quizAsset: ["nil"],
            isRedemption: false,
            quizPrompt: "Pasangkan idiom dibawah ini dengan pasangannya yang tepat",
            quizLeftChoiceList: [
                Choice(choiceID: 1, choiceText: "Rendah Hati"),
                Choice(choiceID: 2, choiceText: "Gulung Tikar"),
                Choice(choiceID: 3, choiceText: "Naik Daun")
            ],
            quizRightChoiceList: [
                Choice(choiceID: 1, choiceText: "Tidak Sombong"),
                Choice(choiceID: 2, choiceText: "Terkenal"),
                Choice(choiceID: 3, choiceText: "Bangkrut"),
            ]
        )
    }
}
