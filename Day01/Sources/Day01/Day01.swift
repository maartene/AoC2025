func getNumberOfRotationsEndingOnZero(for input: String, countAllZeroes: Bool = false) -> Int {
    let instructions = input.split(separator: "\n")
        .map { Instruction(string: $0) }
    
    var dial = Dial()
    var zeroCount = 0
    for instruction in instructions {
        var rotationRemaining = instruction.amount
        
        while rotationRemaining > 0 {
            dial.rotate(instruction.direction)
            rotationRemaining -= 1
            
            if dial.currentPosition == 0 {
                if countAllZeroes || rotationRemaining == 0
                {
                    zeroCount += 1
                }
            }
        }
    }
    
    return zeroCount
}

struct Dial {
    private(set) var currentPosition = 50
    
    mutating func rotate(_ direction: Direction) {
        switch direction {
        case .left: currentPosition -= 1
        case .right: currentPosition += 1
        }
        
        if currentPosition < 0 {
            currentPosition += 100
        }
        if currentPosition > 99 {
            currentPosition -= 100
        }
    }
}

enum Direction: String {
    case left = "L"
    case right = "R"
}

struct Instruction {
    let direction: Direction
    let amount: Int
    
    init(string: any StringProtocol) {
        var characters = string.map { $0 }
        
        self.direction = Direction(rawValue: String(characters[0]))!
        
        characters = Array(characters.dropFirst())
        let numberString = characters.map { String($0) }.joined()
        amount = Int(numberString)!
    }
}
