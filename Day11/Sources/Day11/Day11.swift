import Foundation

// The Swift Programming Language
// https://docs.swift.org/swift-book

func part1(_ input: String) -> Int {
    let connections = parseInput(input)
    
    var currentPathCount = 0
    var queue = ["you"]
    
    while queue.isEmpty == false {
        let currentConnection = queue.removeFirst()
        
        if currentConnection == "out" {
            currentPathCount += 1
        } else {
            for next in connections[currentConnection]! {
                queue.append(next)
            }
        }
    }
    
    return currentPathCount
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
