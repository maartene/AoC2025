// The Swift Programming Language
// https://docs.swift.org/swift-book

import Collections

@main
struct Day10 {
    static func main() {
        let fewestNumberOfPresses = part2(in: input)
        print(fewestNumberOfPresses)
    }
}

func part1(in input: String) -> Int {
    let machines = input.split(separator: "\n")
        .map { Machine($0) }
    
    var count = 0
    let minimumPresses = machines.map {
        print("Working on machine \(count) of \(machines.count)")
        count += 1
        return $0.minimumButtonPressesToMeetLightRequirements()
    }
    
    return minimumPresses.reduce(0, +)
}

func part2(in input: String) -> Int {
    let machines = input.split(separator: "\n")
        .map { Machine($0) }
    
    var count = 0
    let minimumPresses = machines.map {
        print("Working on machine \(count) of \(machines.count)")
        count += 1
        return $0.minimumButtonPressesToMeetJoltageRequirement()
    }
    
    return minimumPresses.reduce(0, +)
}

struct Machine {
    let lights: [Bool]
    let rules: [Set<Int>]
    let joltageRequirements: [Int]
    
    init(_ machineString: any StringProtocol) {
        let parts = machineString.split(separator: " ")
        var rules = [Set<Int>]()
        var joltageRequirements = [Int]()
        var lights = [Bool]()
        
        for part in parts {
            switch part.first! {
            case "[":
                lights = part.dropFirst().dropLast()
                    .map { $0 }
                    .map { $0 == "#" ? true : false }
            case "(":
                let rule = part.dropFirst().dropLast()
                    .split(separator: ",")
                    .compactMap { Int(String($0)) }
                rules.append(Set(rule))
            case "{":
                joltageRequirements = part.dropFirst().dropLast()
                    .split(separator: ",")
                    .compactMap { Int(String($0)) }
            default:
                break
            }
        }
        
        self.lights = lights
        self.rules = rules.sorted(by: { $0.count > $1.count })
        self.joltageRequirements = joltageRequirements
    }
    
    init(lights: [Bool], rules: [Set<Int>], joltageRequirements: [Int]) {
        self.lights = lights
        self.rules = rules
        self.joltageRequirements = joltageRequirements
    }
    
    // Monte Carlo simulation - I'm asstounished this worked!
    func minimumButtonPressesToMeetLightRequirements() -> Int {
        var minimumPresses = Int.max
        for _ in 0 ..< 100_000 {
            var state = Array(repeating: false, count: lights.count)
            
            var pressCount = 0
            while state != lights, pressCount < 1000 {
                pressCount += 1
                let button = rules.randomElement()!
                for index in button {
                    state[index].toggle()
                }
            }
            
            minimumPresses = min(minimumPresses, pressCount)
        }
        return minimumPresses
    }
    
    func minimumButtonPressesToMeetJoltageRequirement() -> Int {
        let startState = joltageRequirements.map { _ in 0 }
        var queue: OrderedDictionary<[Int], Int> = [startState: 0]  // (current point, distance)
        var visited: Set<[Int]> = []
        
        while queue.isEmpty == false {
            print(queue.count)
            let (current, pressCount) = queue.removeFirst()
            visited.insert(current)
            
            // Check if we met the requirements
            if current == joltageRequirements {
                return pressCount
            }
            
            // if one of the joltageRequirements is overcapped, this is an invalid route and should not continue
            var skip = false
            for i in 0 ..< joltageRequirements.count {
                if current[i] > joltageRequirements[i] {
                    skip = true
                }
            }
            
            if skip {
                
            } else {
                // enqueue all possible button presses
                rules.forEach { rule in
                    var newCurrent = current
                    for buttonIndex in rule {
                        newCurrent[buttonIndex] += 1
                    }
                    if visited.contains(newCurrent) == false && queue.keys.contains(newCurrent) == false {
                        queue[newCurrent] = pressCount + 1
                    }
                }
            }
        }
        
        fatalError("Should have found a solution")
    }
}

extension Machine: Equatable { }
