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
    let startPosition = matrix[0].firstIndex { $0 == "S" }!
    
    var beams: [Int: Int] = [startPosition: 1]
    
    for y in 0 ..< matrix.height {
        var updatedBeams = beams.reduce(into: [Int:Int]()) { partialResult, beam in
            partialResult[beam.key] = 0
        }
        
        for beam in beams {
            let beamValue = beam.value
            if matrix[y][beam.key] == "^" {
                updatedBeams.removeValue(forKey: beam.key)
                
                updatedBeams[beam.key - 1, default: 0] += beamValue
                updatedBeams[beam.key + 1, default: 0] += beamValue
            } else {
                updatedBeams[beam.key, default: 0] += beamValue
            }
        }
        beams = updatedBeams
    }
    
    return beams
        .values
        .reduce(0, +)
}

func pathAndSplitCount(in input: String) -> (pathCount: Int, splitCount: Int) {
    let matrix = Matrix<Character>.makeCharacterMatrix(from: input)
    let startPosition = matrix[0].firstIndex { $0 == "S" }!
    
    var beams: [Int: Int] = [startPosition: 1]
    var splitCount = 0
    
    for y in 0 ..< matrix.height {
        var updatedBeams = beams.reduce(into: [Int:Int]()) { partialResult, beam in
            partialResult[beam.key] = 0
        }
        
        for beam in beams {
            let beamValue = beam.value
            if matrix[y][beam.key] == "^" {
                splitCount += 1
                updatedBeams.removeValue(forKey: beam.key)
                
                updatedBeams[beam.key - 1, default: 0] += beamValue
                updatedBeams[beam.key + 1, default: 0] += beamValue
            } else {
                updatedBeams[beam.key, default: 0] += beamValue
            }
        }
        beams = updatedBeams
    }
    
    let pathCount = beams
        .values
        .reduce(0, +)
    
    return (pathCount, splitCount)
}

fileprivate func addBeamValue(_ value: Int, at coord: Vector, to resultMatrix: inout Matrix<Int>) {
    let existingValue = resultMatrix[coord]
    resultMatrix.changeValue(at: coord, to: existingValue + value)
}
