//
//  Baseball.swift
//  Bulls and Cows
//
//  Created by Soo Jang on 6/12/24.
//

import Foundation

struct Baseball {
    private var playCount: [Int] = []
    private var countIndex: Int = 0
    private var tryCount = 0

// MARK: - 랜덤값 주기
    private var secretNum:[Int] {
        let arr = Array(0...9)
        return arr[0] == 0 ? Array(arr[1...3]) : Array(arr[0...2])
    }
// MARK: - 입력값 받기
    private func getAnswer() throws -> [Int]{
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
 // MARK: - 숫자 비교
    mutating func compareNums(secret: [Int],answer: [Int]) -> (score: Bool, gameStatus :String) {
        var strike = 0
        var ball = 0
        if secret == answer {
            tryCount += 1
            playCount.insert(tryCount, at: countIndex)
            countIndex += 1
            tryCount = 0
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
        tryCount += 1
        return (false , statusMessage)
    }
    
    // MARK: - 게임 시작
    mutating func gameStart() {
        print("< 게임을 시작합니다 >")
        let secretNum = secretNum
        print(secretNum)
        while true {
            do {
                print("입력: ",terminator: "")
                let answer = try getAnswer()
                let result = compareNums(secret: secretNum, answer: answer)
                print(result.gameStatus)
                if result.score {
                    print(NameSpace.initialMessage)
                    return
                }
            } catch GetAnswerError.wrongInput {
                print(NameSpace.wrongInputMessage)
                continue
            } catch {
                print("Unknown Error")
            }
        }
    }
    // MARK: - 게임 플레이 횟수 카운트
    func checkPlayingCount() {
        if countIndex == 0 {
            print("아직 게임 기록이 없습니다.")
            return
        }
        print("< 게임 기록 보기 >")
        for i in 0..<self.countIndex {
            print("\(i + 1)번째 게임 : 시도 횟수 - \(playCount[i])\n")
        }
        print(NameSpace.initialMessage)
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
    static let initialMessage = 
        """
        환영합니다! 원하시는 번호를 입력해주세요
        1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
        """
}
