// The Swift Programming Language
// https://docs.swift.org/swift-book

func getNumberOfRotationsEndingOnZero(for input: String, countAllZeroes: Bool = false) -> Int {
    let instructions = input.split(separator: "\n")
        .map { String($0) }
        .map { Instruction(string: $0) }
    
    var currentPosition = 50
    var zeroCount = 0
    for instruction in instructions {
        switch instruction.direction {
        case .left:
            currentPosition = currentPosition - instruction.amount
            while currentPosition < 0 {
                if countAllZeroes, currentPosition != 0 {
                    zeroCount += 1
                }
                currentPosition += 100
            }
        case .right:
            currentPosition = currentPosition + instruction.amount
            while currentPosition > 99 {
                if countAllZeroes, currentPosition != 0 {
                    zeroCount += 1
                }
                currentPosition -= 100
            }
        }
        if currentPosition == 0 {
            zeroCount += 1
        }
    }
    
    return zeroCount
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
