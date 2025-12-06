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
    struct Operation: Sendable {
        let baseValue: Int
        let function: @Sendable (Int, Int) -> Int
    }
    
    private let numbers: [Int]
    private let operation: Operation
    
    var value: Int {
        numbers.reduce(operation.baseValue, operation.function)
    }
    
    private static let operations = [
        "*": Operation(baseValue: 1, function: *),
        "+": Operation(baseValue: 0, function: +)
    ]
    
    init(_ strings: [String]) {
        var numbers = [Int]()
        var currentOperation = Operation(baseValue: 0, function: +)
        
        for string in strings {
            if string == "" {
                // do nothing
            } else if let number = Int(string) {
                numbers.append(number)
            } else if let operation = Problem.operations[string] {
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
            case "*", "+":
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
