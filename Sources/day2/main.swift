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
    
    var x: Int = 0
    
    var depth: Int = 0
    
    for line in inputLines {
        
        let words = line.split(separator: " ")
        
        let value = Int(words[1])!
        
        switch words[0] {
        case "forward":
            x += value
        case "down":
            depth += value
        case "up":
            depth -= value
        default:
            preconditionFailure()
        }
        
    }
    
    print(x * depth)
    
}

func part2() {
    
    var x: Int = 0
    
    var depth: Int = 0
    
    var aim: Int = 0
    
    for line in inputLines {
        
        let words = line.split(separator: " ")
        
        let value = Int(words[1])!
        
        switch words[0] {
        case "forward":
            x += value
            depth += aim * value
        case "down":
            aim += value
        case "up":
            aim -= value
        default:
            preconditionFailure()
        }
        
    }
    
    print(x * depth)
    
}

print("# Part 1")
part1()

print("# Part 2")
part2()
