import Foundation
import Collections

@main
struct Day11 {
    static func main() {
        print("Result: ", part2(input))
    }
}

func part1(_ input: String) -> Int {
    let connections = parseInput(input)
    return bfs(from: "you", to: "out", connections: connections)
}

func part2(_ input: String) -> Int {
    let connections = parseInput(input)
    let fromSvrToFFT = bfs(from: "svr", to: "fft", connections: connections)
    print("connections from svr to fft: \(fromSvrToFFT)")
    let fromFFTtoDAC = bfs(from: "fft", to: "dac", connections: connections)
    print("connections from fft to dac: \(fromFFTtoDAC)")
    let fromDacToOut = bfs(from: "dac", to: "out", connections: connections)
    print("connections from dac to out: \(fromDacToOut)")
    
    return fromSvrToFFT * fromFFTtoDAC * fromDacToOut
}

func bfs(from: String, to: String, connections: [String: [String]]) -> Int {
    var memo: [String: Int] = [:]
    
    func countPaths(from node: String) -> Int {
        // If we've already calculated this, return cached result
        if let cached = memo[node] {
            return cached
        }
        
        // Base case: we've reached the target
        if node == to {
            return 1
        }
        
        // Recursive case: sum paths through all neighbors
        var totalPaths = 0
        for neighbor in connections[node] ?? [] {
            totalPaths += countPaths(from: neighbor)
        }
        
        // Cache and return result
        memo[node] = totalPaths
        return totalPaths
    }
    
    return countPaths(from: from)
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
