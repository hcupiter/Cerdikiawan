//
//  QuizMatchingWordViewModel.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 20/06/24.
//

import Foundation
import SwiftUI

class QuizMatchingWordViewModel: ObservableObject {
    @Published var leftSelectedChoiceId: Int = -1
    @Published var rightSelectedChoiceId: Int = -1
    
    @Published var connectedChoiceId: [(left: Int, right: Int)] = []
    @Published var quizConnect: QuizConnect? = nil
    
    func getAllConnections(choiceLeft: [Choice], choiceRight: [Choice]) -> [(CGPoint, CGPoint)] {
        var connections: [(CGPoint, CGPoint)] = []
        for con in connectedChoiceId {
            if let leftOrder = choiceLeft.firstIndex(where: { con.left == $0.choiceId }),
               let rightOrder = choiceRight.firstIndex(where: { con.right == $0.choiceId }) {
                let leftCoordinate = getLineCoordinate(order: leftOrder+1, selectedFrom: "Left")
                let rightCoordinate = getLineCoordinate(order: rightOrder+1, selectedFrom: "Right")
                connections.append((leftCoordinate, rightCoordinate))
            }
        }
        return connections
    }
    
    func getLineCoordinate(order: Int, selectedFrom: String) -> CGPoint {
        var x: CGFloat = 0
        var y: CGFloat = 0
        if selectedFrom == "Left" {
            x = UIScreen.main.bounds.width / 3
        }else {
            x = 2*UIScreen.main.bounds.width / 3
        }
        y = CGFloat(16*order) * UIScreen.main.bounds.height / 100
        return CGPoint(x: x, y: y)
    }
    
    func handleSelection(choiceId: Int, selectedFrom: String) {
        if leftSelectedChoiceId == choiceId && selectedFrom == "Left" {
            deselectChoice(choiceId: choiceId, selectedFrom: selectedFrom)
        } else if rightSelectedChoiceId == choiceId && selectedFrom == "Right"{
            deselectChoice(choiceId: choiceId, selectedFrom: selectedFrom)
        } else {
            deleteLine(choiceId: choiceId, selectedFrom: selectedFrom)
            selectChoice(choiceId: choiceId, selectedFrom: selectedFrom)
            checkConnection()
        }
    }
    
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
    
    
    func resetVariables(){
        // if ever reach this part of code, regardless what happens, resets all
        leftSelectedChoiceId = -1
        rightSelectedChoiceId = -1
    }
    
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
            quizFeedback: Feedback(quizId: 1, feedbackDescription: "You are stupid ah fuck"),
            quizDifficultyLevel: 4,
            quizCategory: "sambung kata",
            quizTitle: "nil",
            quizAsset: ["nil"],
            isRedemption: false,
            quizPrompt: "Pasangkan idiom dibawah ini dengan pasangannya yang tepat",
            quizLeftChoiceList: [
                Choice(choiceId: 1, choiceDescription: "Rendah Hati"),
                Choice(choiceId: 2, choiceDescription: "Gulung Tikar"),
                Choice(choiceId: 3, choiceDescription: "Naik Daun")
            ],
            quizRightChoiceList: [
                Choice(choiceId: 1, choiceDescription: "Tidak Sombong"),
                Choice(choiceId: 2, choiceDescription: "Terkenal"),
                Choice(choiceId: 3, choiceDescription: "Bangkrut"),
            ]
        )
    }
}
