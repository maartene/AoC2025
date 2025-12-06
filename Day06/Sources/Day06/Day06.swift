import Shared

func sumOfMathProblems(in input: String) -> Int {
    Matrix<String>.makeStringMatrix(from: input)
        .transposed()
        .map {
            Problem($0).value
        }
        .reduce(0, +)
}

func sumOfMathProblemsRightToLeft(in input: String) -> Int {
    readProblemsRightToLeft(input)
        .map {
            $0.value
        }
        .reduce(0, +)
}

struct Problem {
    enum Operation: Character {
        case plus = "+"
        case times = "*"
        
        var baseValue: Int {
            switch self {
            case .plus: return 0
            case.times: return 1
            }
        }
        
        var function: (Int, Int) -> Int {
            switch self {
            case .plus: return (+)
            case.times: return (*)
            }
        }
    }
    
    let numbers: [Int]
    let operation: Operation
    
    var value: Int {
        numbers.reduce(operation.baseValue, operation.function)
    }
    
    init(_ strings: [String]) {
        var numbers = [Int]()
        var currentOperation: Operation = .plus
        
        for string in strings {
            if string == "" {
                // do nothing
            } else if let number = Int(string) {
                numbers.append(number)
            } else if let operation = Operation(rawValue: Character(string)) {
                currentOperation = operation
            }
        }
        
        self.operation = currentOperation
        self.numbers = numbers
    }
}

func readProblemsRightToLeft(_ input: String) -> [Problem] {
    let matrix = Matrix<Character>.makeCharacterMatrix(from: input)
    
    var problems = [Problem]()
    var problem = [String]()
    for columnIndexReversed in 0..<matrix.width {
        let columnIndex = matrix.width - 1 - columnIndexReversed
        var column = ""
        for rowIndex in 0..<matrix.height {
            let character = String(matrix[rowIndex][columnIndex])
            switch character {
            case " ":
                problem.append(column)
                column = ""
            case "*":
                problem.append(column)
                column = ""
                problem.append(character)
                problems.append(Problem(problem))
                problem = []
            case "+":
                problem.append(column)
                column = ""
                problem.append(character)
                problems.append(Problem(problem))
                problem = []
            default:
                column += character
            }
        }
    }
    
    return problems
}
