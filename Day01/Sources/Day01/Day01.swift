// The Swift Programming Language
// https://docs.swift.org/swift-book

func getNumberOfRotationsEndingOnZero(for input: String) -> Int {
    let instructions = [
        Instruction(direction: .left, amount: 68),
        Instruction(direction: .left, amount: 30),
        Instruction(direction: .right, amount: 48),
        Instruction(direction: .left, amount: 5),
        Instruction(direction: .right, amount: 60),
        Instruction(direction: .left, amount: 55),
        Instruction(direction: .left, amount: 1),
        Instruction(direction: .left, amount: 99),
        Instruction(direction: .right, amount: 14),
        Instruction(direction: .left, amount: 82),
    ]
    
    var endStates = [50]
    
    for instruction in instructions {
        var currentPosition = endStates.last!
        switch instruction.direction {
        case .left:
            currentPosition = currentPosition - instruction.amount
            if currentPosition < 0 {
                currentPosition += 100
            }
        case .right:
            currentPosition = currentPosition + instruction.amount
            if currentPosition > 99 {
                currentPosition -= 100
            }
        }
        endStates.append(currentPosition)
    }
    
    return endStates.count(where: { $0 == 0 })
}

struct Instruction {
    enum Direction {
        case left
        case right
    }
    
    let direction: Direction
    let amount: Int
}
