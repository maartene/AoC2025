// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftZ3

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
        // Use Swift Z3 solver
        let config = Z3Config()
        let context = Z3Context(configuration: config)
        let solver = context.makeOptimize()
        
        // Create integer variables for each button (rule)
        let buttons = rules.enumerated().map { index, _ -> Z3Int in
            let buttonName = "b\(index)"
            return context.makeConstant(name: buttonName)
        }
        
        // Add constraints: each button press count >= 0
        for button in buttons {
            solver.add(button >= 0)
        }
        
        // Add constraints: sum of button presses affecting each requirement equals the requirement value
        for (requirementIndex, requirementValue) in joltageRequirements.enumerated() {
            let affectingButtons = rules.enumerated().compactMap { ruleIndex, rule -> Z3ArithExpr? in
                if rule.contains(requirementIndex) {
                    return buttons[ruleIndex]
                }
                return nil
            }
            
            if !affectingButtons.isEmpty {
                let sum = affectingButtons.reduce(Z3IntValue(0, context: context)) { $0 + $1 }
                solver.add(sum == Int32(requirementValue))
            }
        }
        
        // Minimize the total sum of button presses
        let totalPresses = buttons.reduce(Z3IntValue(0, context: context)) { $0 + $1 }
        solver.minimize(totalPresses)
        
        // Check for solution
        let result = solver.check()
        
        if result == .satisfiable {
            let model = solver.getModel()
            let total = buttons.reduce(0) { result, button in
                if let value = model.eval(button) {
                    return result + Int(value.intValue)
                }
                return result
            }
            return total
        }
        
        // If no solution found, return -1 (though problem states there's always a solution)
        return -1
    }
}

extension Machine: Equatable { }
