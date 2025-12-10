// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct Day10 {
    static func main() {
        let fewestNumberOfPresses = part1(in: input)
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
        self.rules = rules
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
        10
    }
}

extension Machine: Equatable { }
