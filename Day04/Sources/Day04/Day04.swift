import Shared

func numberOfAccessibleRolls(in input: String) -> Int {
    let rolls = getRollsFromInput(input)
    
    return rolls.count { roll in
        countNeighbours(for: roll, in: rolls) < 4
    }
}

func numberOfRollsThatCanBeRemoved(in input: String) -> Int {
    var rolls = getRollsFromInput(input)
    
    var removedRolls = 0
    
    while let rollToRemove = rollThatCanBeRemoved(in: rolls) {
        rolls.remove(rollToRemove)
        removedRolls += 1
    }
    
    return removedRolls
}

private func rollThatCanBeRemoved(in rolls: Set<Vector>) -> Vector? {
    rolls.first {
        countNeighbours(for: $0, in: rolls) < 4
    }
}

private func countNeighbours(for coord: Vector, in rolls: Set<Vector>) -> Int {
    let neighbours = coord.neighbours8
    return neighbours.count {
        rolls.contains($0)
    }
}

private func getRollsFromInput(_ input: String) -> Set<Vector> {
    var rolls = Set<Vector>()
    let matrix = convertInputToMatrixOfCharacters(input)
    for row in 0 ..< matrix.count {
        for column in 0 ..< matrix[row].count {
            if matrix[row][column] == "@" {
                rolls.insert(Vector(x: column, y: row))
            }
        }
    }
    return rolls
}
