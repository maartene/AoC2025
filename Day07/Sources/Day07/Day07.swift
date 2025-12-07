import Shared

func splitCount(in input: String) -> Int {
    let matrix = Matrix<Character>.makeCharacterMatrix(from: input)
    
    var splitCount = 0
    let start = matrix[0].firstIndex { $0 == "S" }!
    
    var beams: Set<Int> = [start]
    
    for y in 0 ..< matrix.height {
        var updatedBeams = beams
        for beam in beams {
            if matrix[y][beam] == "^" {
                updatedBeams.remove(beam)
                splitCount += 1
                
                updatedBeams.insert(beam - 1)
                updatedBeams.insert(beam + 1)
            }
        }
        beams = updatedBeams
    }
    
    return splitCount
}


func pathCount(in input: String) -> Int {
    let matrix = Matrix<Character>.makeCharacterMatrix(from: input)
    var resultMatrix = Matrix(
        Array(repeating: Array(repeating: 0, count: matrix.width), count: matrix.height)
    )
    
    let startPosition = matrix[0].firstIndex { $0 == "S" }!
    resultMatrix.changeValue(at: Vector(x: startPosition, y: 0), to: 1)
    
    var beams: Set<Int> = [startPosition]
    
    for y in 1 ..< matrix.height {
        var updatedBeams = beams
        for beam in beams {
            let beamValue = resultMatrix[beam, y - 1]
            if matrix[y][beam] == "^" {
                updatedBeams.remove(beam)
                
                addBeamValue(beamValue, at: Vector(x: beam - 1, y: y), to: &resultMatrix)
                updatedBeams.insert(beam - 1)
                addBeamValue(beamValue, at: Vector(x: beam + 1, y: y), to: &resultMatrix)
                updatedBeams.insert(beam + 1)
            } else {
                addBeamValue(beamValue, at: Vector(x: beam, y: y), to: &resultMatrix)
            }
        }
        beams = updatedBeams
    }
    
    let lastRow = resultMatrix.rows.last ?? []
    return lastRow.reduce(0, +)
}

fileprivate func addBeamValue(_ value: Int, at coord: Vector, to resultMatrix: inout Matrix<Int>) {
    let existingValue = resultMatrix[coord]
    resultMatrix.changeValue(at: coord, to: existingValue + value)
}
