//
//  File.swift
//  
//
//  Created by 김성민 on 2022/03/25.
//

import Foundation

let inputFileLines = try! String(
    contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!
).split(separator: "\n")


struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Line {
    var start: Point
    var end: Point
}

var lines: [Line] = inputFileLines.map {
    
    let components = $0.components(separatedBy: "->").map { $0.trimmingCharacters(in: .whitespaces) }
    
    let startString = components.first!
    
    let endString = components.last!
    
    let startNumberStrings = startString.split(separator: ",")
    let start = Point(x: .init(startNumberStrings.first!)!, y: .init(startNumberStrings.last!)!)
    
    let endNumberStrings = endString.split(separator: ",")
    let end = Point(x: .init(endNumberStrings.first!)!, y: .init(endNumberStrings.last!)!)
    
    return Line(start: start, end: end)
    
}



var marks: [Point: Int] = [:]


func part1() {
    
    for line in lines {
        
        if line.start.x == line.end.x {
            
            let x = line.start.x
            
            for y in min(line.start.y, line.end.y)...max(line.start.y, line.end.y) {
                
                marks[Point(x: x, y: y), default: 0] += 1
                
            }
            
        } else if line.start.y == line.end.y {

            let y = line.start.y
            
            for x in min(line.start.x, line.end.x)...max(line.start.x, line.end.x) {
                
                marks[Point(x: x, y: y), default: 0] += 1
                
            }
            
        } else {
            continue // diagnoal
        }
        
    }

    let result = marks.values.reduce(0, { $0 + ($1 > 1 ? 1 : 0) })

    print("Part 1: \(result)")

}


func part2() {
    
    for line in lines where line.start.x != line.end.x && line.start.y != line.end.y {
        
        // precondition(abs(line.end.x - line.start.x) == abs(line.end.y - line.start.y))
        
        let xDirection: Int = (line.end.x > line.start.x) ? 1 : -1
        
        let yDirection: Int = (line.end.y > line.start.y) ? 1 : -1
        
        let steps = abs(line.end.x - line.start.x) + 1
        
        for i in 0..<steps {
            
            var point = line.start
            
            point.x += xDirection * i
            point.y += yDirection * i
            
            marks[point, default: 0] += 1
            
        }
        
    }

    let result = marks.values.reduce(0, { $0 + ($1 > 1 ? 1 : 0) })

    print("Part 2: \(result)")
    
}


part1()

part2()


//
//
//for y in 0..<10 {
//
//    for x in 0..<10 {
//
//        if let count = marks[Point(x: x, y: y)] {
//            print(count, terminator: "")
//        } else {
//            print(".", terminator: "")
//        }
//
//    }
//
//    print()
//
//}

