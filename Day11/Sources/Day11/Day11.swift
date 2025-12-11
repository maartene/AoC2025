import Foundation

@main
struct Day11 {
    static func main() {
        print("Result: ", part2(input))
    }
}

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


// from dac to out: 23101

func part2(_ input: String) -> Int {
    let connections = parseInput(input)
    let fromSvrToFFT = bfs(from: "svr", to: "fft", connections: connections)
    let fromFFTtoDAC = bfs(from: "fft", to: "dac", connections: connections)
    let fromDacToOut = bfs(from: "dac", to: "out", connections: connections)
    
    return fromSvrToFFT * fromFFTtoDAC * fromDacToOut
}

func bfs(from: String, to: String, connections: [String: [String]]) -> Int {
    var queue = [from]
    
    var currentPathCount = 0
    while queue.isEmpty == false {
        let currentConnection = queue.removeLast()
        
        if currentConnection == to {
            currentPathCount += 1
        } else {
            for next in connections[currentConnection] ?? [] {
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
