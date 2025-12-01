// The Swift Programming Language
// https://docs.swift.org/swift-book

func getNumberOfRotationsEndingOnZero(for input: String, countAllZeroes: Bool = false) -> Int {
    let instructions = input.split(separator: "\n")
        .map { String($0) }
        .map { Instruction(string: $0) }
    
    var currentPosition = 50
    var zeroCount = 0
    for instruction in instructions {
        var rotationRemaining = instruction.amount
        switch instruction.direction {
        case .left:
            while rotationRemaining > 0 {
                currentPosition -= 1
                if currentPosition < 0 {
                    currentPosition += 100
                }
                if currentPosition == 0 {
                    if countAllZeroes || rotationRemaining == 1
                    {
                        zeroCount += 1
                    }
                }
                
                rotationRemaining -= 1
            }
        case .right:
            while rotationRemaining > 0 {
                currentPosition += 1
                if currentPosition > 99 {
                    currentPosition -= 100
                }
                
                if currentPosition == 0 {
                    if countAllZeroes || rotationRemaining == 1
                    {
                        zeroCount += 1
                    }
                }                
                rotationRemaining -= 1
            }
        }
        
        print(instruction, currentPosition, zeroCount)
    }
    
    return zeroCount
}

struct Instruction {
    enum Direction: String {
        case left = "L"
        case right = "R"
    }
    
    let direction: Direction
    let amount: Int
    
    init(string: String) {
        var characters = string.map { $0 }
        
        guard let direction = Direction(rawValue: String(characters[0])) else {
            fatalError("Unexpected character: \(characters[0])")
        }
        self.direction = direction
        
        characters = Array(characters.dropFirst())
        let numberString = characters.map { String($0) }.joined()
        amount = Int(numberString)!
    }
}

extension Instruction: CustomStringConvertible {
    var description: String {
        "\(direction.rawValue)\(amount)"
    }
}
