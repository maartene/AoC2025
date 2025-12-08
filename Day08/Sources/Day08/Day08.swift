import Foundation
import Shared
import Algorithms

func part1(_ input: String, numberOfPairsToConnect: Int) -> Int {
    let junctionBoxes = loadJunctionBoxes(input)
    
    var circuits = Set(junctionBoxes.map {
        Circuit(junctionBoxes: [$0])
    })
    
    let junctionBoxPairs = Set(junctionBoxes.combinations(ofCount: 2)
        .map {
            Pair(v1: $0[0], v2: $0[1])
        }
                               )
    let pairsIncludingDistance = junctionBoxPairs.map { pair in
        let distance = pair.v1.distanceTo(pair.v2)
        return (pair, distance)
    }
    
    let sortedPairs = pairsIncludingDistance.sorted(by: { $0.1 < $1.1 })
        .map { $0.0 }
    
    // try and combine circuits
    for i in 0 ..< numberOfPairsToConnect {
        let pair = sortedPairs[i]
        print(circuits.map { $0.junctionBoxes.count })
        let circuit1 = circuits.first(where: { $0.junctionBoxes.contains(pair.v1) })
        let circuit2 = circuits.first(where: { $0.junctionBoxes.contains(pair.v2) })
        
        if var circuit1, let circuit2, circuit1 != circuit2 {
            // combine circuits
            circuits.remove(circuit1)
            circuits.remove(circuit2)
            circuit1.junctionBoxes = circuit1.junctionBoxes.union(circuit2.junctionBoxes)
            circuits.insert(circuit1)
        }
    }
    
    let circuitSizes = circuits.map { $0.junctionBoxes.count }
     
    let expectedCircuitSizes: Set = [
        5, 4, 2, 2, 1, 1, 1, 1, 1, 1, 1
    ]
    
    let threeLargest = circuitSizes.sorted(by: >)
        .prefix(3)
        .reduce(1, *)
    
    return threeLargest
}

struct Circuit: Equatable, Hashable {
    var junctionBoxes: Set<Vector3>
}

struct Vector3: Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    func distanceTo(_ other: Vector3) -> Double {
        let dx = Double(self.x - other.x)
        let dy = Double(self.y - other.y)
        let dz = Double(self.z - other.z)
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}

struct Pair: Equatable, Hashable {
    static func == (lhs: Pair, rhs: Pair) -> Bool {
        lhs.v1 == rhs.v1 && lhs.v2 == rhs.v2 ||
        lhs.v1 == rhs.v2 && lhs.v2 == rhs.v1
    }
    
    let v1: Vector3
    let v2: Vector3
    
    func hash(into hasher: inout Hasher) {
        let set = Set([v1, v2])
        hasher.combine(set)
    }
}

private func loadJunctionBoxes(_ input: String) -> [Vector3] {
    let numbers = convertStringToIntMatrix(input, separator: ",")
    return numbers.map { line in
        Vector3(x: line[0], y: line[1], z: line[2])
    }
}
