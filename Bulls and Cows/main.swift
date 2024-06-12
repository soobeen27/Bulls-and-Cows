//
//  main.swift
//  Bulls and Cows
//
//  Created by Soo Jang on 6/12/24.
//

import Foundation

print("< 게임을 시작합니다 >")
let baseball = Baseball()
let secretNum = baseball.secretNum
while true {
    do {
        print("입력: ",terminator: "")
        let answer = try baseball.getAnswer()
        let result = baseball.compareNums(secret: secretNum, answer: answer)
        print(result.gameStatus)
        if result.score {
            break
        }
    } catch GetAnswerError.wrongInput {
        print(NameSpace.wrongInputMessage)
        continue
    }
}
