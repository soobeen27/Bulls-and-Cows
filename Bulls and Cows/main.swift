//
//  main.swift
//  Bulls and Cows
//
//  Created by Soo Jang on 6/12/24.
//

import Foundation
print(NameSpace.initialMessage)
var baseBall = Baseball()
while true {
    print("입력: ",terminator:"")
    guard let input = readLine() else 
    { print("올바른 숫자를 입력해주세요!")
        continue
    }
    switch input {
    case "1":
        baseBall.gameStart()
        continue
    case "2":
        baseBall.checkPlayingCount()
        continue
    case "3":
        print("< 숫자 야구 게임을 종료합니다 >")
        break
    default:
        print("올바른 숫자를 입력해주세요.")
        continue
    }
    break
}


