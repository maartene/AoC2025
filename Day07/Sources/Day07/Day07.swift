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
                
                if updatedBeams.contains(beam - 1) == false {
                    updatedBeams.insert(beam - 1)
                }
                
                if updatedBeams.contains(beam + 1) == false {
                    updatedBeams.insert(beam + 1)
                }
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
    
    let start = matrix[0].firstIndex { $0 == "S" }!
    resultMatrix.changeValue(at: Vector(x: start, y: 0), to: 1)
    
    var beams: Set<Int> = [start]
    
    for y in 1 ..< matrix.height {
        var updatedBeams = beams
        for beam in beams {
            let beamValue = resultMatrix[beam, y - 1]
            if matrix[y][beam] == "^" {
                updatedBeams.remove(beam)
                
                resultMatrix.changeValue(at: Vector(x: beam - 1, y: y), to: resultMatrix[beam - 1, y] + beamValue)
                updatedBeams.insert(beam - 1)
                resultMatrix.changeValue(at: Vector(x: beam + 1, y: y), to: resultMatrix[beam + 1, y] + beamValue)
                updatedBeams.insert(beam + 1)
            } else {
                resultMatrix.changeValue(at: Vector(x: beam, y: y), to: resultMatrix[beam, y] + beamValue)
            }
        }
        beams = updatedBeams
    }
    
    let result = resultMatrix
        .rows[matrix.height - 1]
        .reduce(0, +)

    return result
}
