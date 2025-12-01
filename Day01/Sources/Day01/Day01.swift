// The Swift Programming Language
// https://docs.swift.org/swift-book

func getNumberOfRotationsEndingOnZero(for input: String) -> Int {
    let instructions = input.split(separator: "\n")
        .map { String($0) }
        .map { Instruction(string: $0) }
    
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
    
    init(string: String) {
        var characters = string.map { $0 }
        
        let directionCharacter = characters[0]
        switch directionCharacter {
        case "R": direction = .right
        case "L": direction = .left
        default:
            direction = .left
            fatalError("Unexpected character: \(directionCharacter)")
        }
        
        characters = Array(characters.dropFirst())
        let numberString = characters.map { String($0) }.joined()
        amount = Int(numberString)!
    }
}
