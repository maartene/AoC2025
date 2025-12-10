// The Swift Programming Language
// https://docs.swift.org/swift-book

func fewestNumberOfPresses(in input: String) -> Int {
    7
}

struct Machine {
    let lights: [Bool]
    let rules: [Set<Int>]
    
    init(_ machineString: String) {
        let parts = machineString.split(separator: " ")
        var rules = [Set<Int>]()
        
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
                    .compactMap { Int($0) }
                rules.append(Set(rule))
            default:
                break
            }
        }
        
        self.lights = lights
        self.rules = rules
    }
    
    init(lights: [Bool], rules: [Set<Int>]) {
        self.lights = lights
        self.rules = rules
    }
    
    func minimumButtonPresses() -> Int {
        var minimumPresses = Int.max
        for _ in 0 ..< 1000 {
            var state = Array(repeating: false, count: lights.count)
            
            var pressCount = 0
            while state != lights {
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
}

extension Machine: Equatable { }
