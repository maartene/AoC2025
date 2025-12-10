// The Swift Programming Language
// https://docs.swift.org/swift-book

struct Machine {
    let lights: [Bool]
    let rules: [Set<Int>]
    
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
