func getNumberOfRotationsEndingOnZero(for input: String, countAllZeroes: Bool = false) -> Int {
    let instructions = input.split(separator: "\n")
        .map { String($0) }
        .map { Instruction(string: $0) }
    
    var currentPosition = 50
    var zeroCount = 0
    for instruction in instructions {
        var rotationRemaining = instruction.amount
        
        while rotationRemaining > 0 {
            currentPosition += instruction.direction.increment
            rotationRemaining -= 1
            
            if currentPosition < 0 {
                currentPosition += 100
            }
            if currentPosition > 99 {
                currentPosition -= 100
            }
            
            if currentPosition == 0 {
                if countAllZeroes || rotationRemaining == 0
                {
                    zeroCount += 1
                }
            }
        }
    }
    
    return zeroCount
}

struct Instruction {
    enum Direction: String {
        case left = "L"
        case right = "R"
        
        var increment: Int {
            switch self {
            case .left: return -1
            case .right: return 1
            }
        }
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
