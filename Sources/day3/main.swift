//
//  File.swift
//  
//
//  Created by 김성민 on 2021/12/09.
//

import Foundation

let _inputFileLines = try! String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!)
    .split(separator: "\n")

var inputLines: Array<Substring>.Iterator {
    _inputFileLines.makeIterator()
}

func part1() {
    
    struct Count {
        var zero: Int = 0
        var one: Int = 0
    }
    
    var counts: [Count] = .init(repeating: .init(), count: 12)
    
    let zeroCharacterValue = "0".utf8.first!
    
    for line in inputLines {
        
        for (index, bit) in line.utf8.enumerated() {
            
            if bit == zeroCharacterValue {
                counts[index].zero += 1
            } else {
                counts[index].one += 1
            }
            
        }
        
    }
    
    let gamma = counts.enumerated().reduce(into: 0) { result, arg in
        
        let shift = counts.count - 1 - arg.offset
        
        let value = (arg.element.one > arg.element.zero) ? 1 : 0
        
        result |= value << shift
        
    }
    
    let epsilon = counts.enumerated().reduce(into: 0) { result, arg in
        
        let shift = counts.count - 1 - arg.offset
        
        let value = (arg.element.one < arg.element.zero) ? 1 : 0
        
        result |= value << shift
        
    }
    
    print(gamma * epsilon)
    
}

func part2() {
    
}


print("# Part 1")
part1()

print("# Part 2")
part2()

