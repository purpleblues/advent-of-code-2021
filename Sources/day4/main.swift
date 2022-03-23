//
//  File.swift
//  
//
//  Created by 김성민 on 2022/03/23.
//

import Foundation

let inputFileLines = try! String(
    contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!
).split(separator: "\n")


let boardSize = 5

struct Board {
    
    private var values: [(Int, Bool)] = []
    
    init<S: Sequence>(lines: S) where S.Element == String.SubSequence {
        
        values.reserveCapacity(boardSize * boardSize)
        
        for line in lines {
            
            values.append(contentsOf: line.split(separator: " ").map { (Int($0)!, false) })
            
        }
        
    }
    
    var didAlreadyWin: Bool = false
    
    mutating func mark(_ value: Int) {
        
        for i in values.indices {
            if values[i].0 == value {
                values[i].1 = true
                return
            }
        }
        
    }
    
    var didWin: Bool {
        
        for i in stride(from: values.startIndex, to: values.endIndex, by: boardSize) {
            
            if values[i ..< i + boardSize].allSatisfy({ $0.1 }) {
                return true
            }
            
        }
        
        for column in 0..<5 {
            
            if stride(from: 0, to: boardSize * boardSize, by: boardSize)
                .allSatisfy({ values[$0 + column].1 }) {
                return true
            }
            
        }
        
        return false
        
    }
    
    var sumOfUnmarked: Int {
        
        values.reduce(0, { $0 + ($1.1 ? 0 : $1.0) })
        
    }
    
}



var boards = stride(from: inputFileLines.startIndex + 1,
                    to: inputFileLines.endIndex,
                    by: 5).map { i in
    
    Board(lines: inputFileLines[i ..< i + boardSize])
    
}



var winningOrder: Int = 0

for input in inputFileLines[0].split(separator: ",").map({ Int($0)! }) {
    
    for i in boards.indices where boards[i].didAlreadyWin == false {
        
        boards[i].mark(input)
        
        guard boards[i].didWin else { continue }
        
        boards[i].didAlreadyWin = true
        
        let score = boards[i].sumOfUnmarked * input
        
        if winningOrder == 0 {
            print(score)
        } else if winningOrder == boards.count - 1 {
            print(score)
            exit(0)
        }
        
        winningOrder += 1
        
    }
    
}

preconditionFailure()
