import Shared

func numberOfAccessibleRolls(in input: String) -> Int {
    let rolls = getRollsFromInput(input)
    
    return rolls.count { roll in
        countNeighbours(for: roll, in: rolls) < 4
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
