//
//  main.swift
//
//
//  Created by 김성민 on 2021/12/06.
//

import Foundation

let _inputFileLines = try! String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!)
    .split(separator: "\n")

var inputLines: Array<Substring>.Iterator {
    _inputFileLines.makeIterator()
}

extension Sequence where Element: Comparable {
    
    func increasingCount() -> Int {
        
        zip(self, self.dropFirst())
            .reduce(0) { count, arg in
                count + ((arg.0 < arg.1) ? 1 : 0)
            }
        
    }
    
}

func part1v2() {
    
    let result = inputLines.lazy.map { Int($0)! }.increasingCount()
    
    print(result)
    
}

extension Sequence where Element == Int {
    
    func accumuatedByThree() -> some Sequence {
        
        zip(self, zip(self.dropFirst(), self.dropFirst().dropFirst())).map { arg in
            arg.0 + arg.1.0 + arg.1.1
        }
        
    }
    
}


func part2() {
    
    var window: (Int, Int, Int) = (0, 0, 0)
    
    var iterator = inputLines
    
    // Precondition: input count >= 3
    
    window.0 = Int(iterator.next()!)!
    window.1 = Int(iterator.next()!)!
    window.2 = Int(iterator.next()!)!
    
    var count = 0
    
    for line in iterator {
        
        let value = Int(line)!
        
        let currentSum = window.1 + window.2 + value
        
        let previousSum = window.0 + window.1 + window.2
        
        if currentSum > previousSum {
            count += 1
        }
        
        // Slide window
        window.0 = window.1
        window.1 = window.2
        window.2 = value
        
    }
    
    print(count)
    
}

func part2v2() {
    
    let inputNumbers = inputLines.lazy.map { Int($0)! }
    
    let sequence = zip(inputNumbers, zip(inputNumbers.dropFirst(), inputNumbers.dropFirst().dropFirst()))
    
    var previous: Int = .max
    
    var count = 0
    
    for window in sequence {
        
        let currentSum = window.0 + window.1.0 + window.1.1
        
        defer {
            previous = currentSum
        }
        
        if currentSum > previous {
            count += 1
        }
        
    }
    
    print(count)
    
}


struct WindowSequence<Base: Sequence>: Sequence {
    
    typealias Element = [Base.Element]
    
    struct Iterator: IteratorProtocol {
        
        private var base: Base.Iterator
        
        private var buffer: [Base.Element] = []
        
        private let windowSize: Int
        
        init(base: Base.Iterator, windowSize: Int) {
            self.base = base
            self.windowSize = windowSize
        }
        
        mutating func next() -> [Base.Element]? {
            
            let remainingCount = windowSize - buffer.count
            
            assert(remainingCount == windowSize || remainingCount == 0)
            
            let countToAppend: Int
            
            if remainingCount == windowSize {
                
                self.buffer.reserveCapacity(windowSize)
                
                countToAppend = remainingCount
                
            } else {
                
                self.buffer.removeFirst()
                
                countToAppend = 1
                
            }
            
            for _ in 0..<countToAppend {
                
                if let value = base.next() {
                    buffer.append(value)
                }
                
            }
            
            if buffer.count < windowSize {
                return nil
            } else {
                return buffer
            }
            
        }
        
    }
    
    private let base: Base
    
    private let windowSize: Int
    
    init(base: Base, windowSize: Int) {
        precondition(windowSize > 0)
        self.base = base
        self.windowSize = windowSize
    }
    
    func makeIterator() -> Iterator {
        Iterator(base: base.makeIterator(), windowSize: windowSize)
    }
    
}



extension Sequence {
    
    func windowed(by windowSize: Int) -> WindowSequence<Self> {
        WindowSequence(base: self, windowSize: windowSize)
    }
    
}

func part2v3() {
    
    let inputNumbers = inputLines.lazy.map { Int($0)! }
    
    let previous = inputNumbers.windowed(by: 3)
    
    let current = inputNumbers.dropFirst().windowed(by: 3)
    
    let count = zip(previous, current).reduce(into: 0) { count, arg in
        
        let previousSum = arg.0.reduce(0, +)
        
        let currentSum = arg.1.reduce(0, +)
        
        if currentSum > previousSum {
            count += 1
        }
        
    }
    
    print(count)
    
}


print("# Part 1")
part1v2()

print("# Part 2")
part2()
