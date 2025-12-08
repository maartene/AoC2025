import Foundation

// The Swift Programming Language
// https://docs.swift.org/swift-book

func part1(_ input: String) -> Int {
    let circuitSizes = [
        5, 4, 2, 2, 1, 1, 1, 1, 1, 1, 1
    ].shuffled()
    
    let threeLargest = circuitSizes.sorted(by: >)
        .prefix(3)
        .reduce(1, *)
    
    return threeLargest
}
