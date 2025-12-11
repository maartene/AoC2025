import Foundation

// The Swift Programming Language
// https://docs.swift.org/swift-book

func part1(_ input: String) -> Int {
    return 5
}

func parseInput(_ input: String) -> [String: [String]] {
    let lines = input.split(separator: "\n")
    
    let result = lines.reduce(into: [String: [String]]()) { dictionary, line in
        let parts = line.split(separator: ":")
        let key = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
        
        let values = parts[1].split(separator: " ")
            .map { String($0) }
        
        dictionary[key] = values
    }
    
    return result
}
