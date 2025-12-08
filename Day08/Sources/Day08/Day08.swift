import Foundation
import Shared
import Algorithms

func part1(_ input: String, numberOfPairsToConnect: Int) -> Int {
    connectJunctionBoxes(input, numberOfPairsToConnect: numberOfPairsToConnect).circuitSizeMultiple
}

func part2(_ input: String) -> Int {
    let result = connectJunctionBoxes(input, numberOfPairsToConnect: Int.max).firstPair!
    
    return result.v1.x * result.v2.x
}

private func connectJunctionBoxes(_ input: String, numberOfPairsToConnect: Int) -> (circuitSizeMultiple: Int, firstPair: Pair?) {
    let junctionBoxes = loadJunctionBoxes(input)
    let sortedPairsOfJunctionBoxes = Set(junctionBoxes.combinations(ofCount: 2)
        .map { combination in
            Pair(v1: combination[0], v2: combination[1])
        }) // create a set of all possible pairs
        .sorted(by: { $0.distance < $1.distance })
    
    var circuits = Circuits(junctionBoxes: junctionBoxes)
    var firstPairToCompleteCircuit: Pair?
    
    // try and combine circuits
    for i in 0 ..< min(numberOfPairsToConnect, sortedPairsOfJunctionBoxes.count) {
        let pair = sortedPairsOfJunctionBoxes[i]
        let circuit1 = circuits.find(containing: pair.v1)
        let circuit2 = circuits.find(containing: pair.v2)
        
        if let circuit1, let circuit2, circuit1 != circuit2 {
            circuits.merge(circuit1, circuit2)
        }
        
        if circuits.count == 1, firstPairToCompleteCircuit == nil {
            firstPairToCompleteCircuit = pair
        }
    }
    
    let threeLargest = circuits.circuitSizes
        .sorted(by: >)
        .prefix(3)
        .reduce(1, *)
    
    return (threeLargest, firstPairToCompleteCircuit)
}

struct Circuits {
    private var circuits: Set<Circuit>
    
    init(junctionBoxes: any Collection<Vector3>) {
        self.circuits = Set(
            junctionBoxes.map { Circuit(junctionBoxes: [$0]) }
        )
    }
    
    func find(containing junctionBox: Vector3) -> Circuit? {
        circuits.first { $0.contains(junctionBox: junctionBox) }
    }
    
    mutating func merge(_ circuit1: Circuit, _ circuit2: Circuit) {
        circuits.remove(circuit1)
        circuits.remove(circuit2)
        circuits.insert(circuit1.combineWith(circuit2))
    }
    
    var count: Int {
        circuits.count
    }
    
    var circuitSizes: [Int] {
        circuits.map { $0.size }
    }
}

struct Circuit: Equatable, Hashable {
    private let junctionBoxes: Set<Vector3>
    
    init(junctionBoxes: Set<Vector3>) {
        self.junctionBoxes = junctionBoxes
    }
    
    func combineWith(_ other: Circuit) -> Circuit {
        Circuit(junctionBoxes: junctionBoxes.union(other.junctionBoxes))
    }
    
    var size: Int {
        junctionBoxes.count
    }
    
    func contains(junctionBox: Vector3) -> Bool {
        junctionBoxes.contains(junctionBox)
    }
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
    
    var distance: Double {
        v1.distanceTo(v2)
    }
}

private func loadJunctionBoxes(_ input: String) -> [Vector3] {
    let numbers = convertStringToIntMatrix(input, separator: ",")
    return numbers.map { line in
        Vector3(x: line[0], y: line[1], z: line[2])
    }
}
