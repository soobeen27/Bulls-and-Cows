//
//  Baseball.swift
//  Bulls and Cows
//
//  Created by Soo Jang on 6/12/24.
//

import Foundation

class Baseball {
    var secretNum: [Int] {
        var numSet = Set<Int>()
        while numSet.count < NameSpace.numLength {
            numSet.insert(Int.random(in: 1...9))
        }
        let numArr: [Int] = numSet.map { $0 }
        return numArr
    }
    
    func getAnswer() throws -> [Int]{
        guard let input = readLine() else { throw GetAnswerError.wrongInput }
        var nums = [Int]()
        for char in input {
            guard let num = Int(String(char)) else {
                throw GetAnswerError.wrongInput
            }
            nums.append(num)
        }
        
        guard nums.count == NameSpace.numLength, Set(nums).count == NameSpace.numLength else {
            throw GetAnswerError.wrongInput
        }
        return nums
    }
    
    func compareNums(secret: [Int],answer: [Int]) -> (score: Bool, gameStatus :String) {
        var strike = 0
        var ball = 0
        if secret == answer {
            return (true ,NameSpace.winMessage)
        }
        for i in 0..<secret.count {
            if secret[i] == answer[i] {
                strike += 1
                continue
            }
            for j in 0..<secret.count {
                if secret[i] == answer [j] {
                    ball += 1
                }
            }
        }
        var statusMessage = ""
        if strike == 0 && ball == 0 { statusMessage = NameSpace.nothingMessage }
        else if strike != 0 && ball == 0 { statusMessage = "\(strike)" + NameSpace.strikeMessage  }
        else if strike == 0 && ball != 0 { statusMessage = "\(ball)" + NameSpace.ballMessage  }
        else { statusMessage = "\(strike)" + NameSpace.strikeMessage + " \(ball)" + NameSpace.ballMessage }
        return (false , statusMessage)
    }
}



enum GetAnswerError: Error {
    case wrongInput
}

enum NameSpace {
    static let numLength = 3
    static let winMessage = "정답입니다!"
    static let wrongInputMessage = "올바르지 않은 입력값입니다."
    static let strikeMessage = "스트라이크"
    static let ballMessage = "볼"
    static let nothingMessage = "Nothing"
}

