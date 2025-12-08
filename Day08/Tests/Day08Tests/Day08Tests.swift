import Testing
@testable import Day08

let exampleInput =
"""
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
"""

@Suite struct `to get the first star on day 08` {
    @Test func `the sizes of the three largest circuits multiplied together for the example input should be 40`() {
        #expect(part1(exampleInput, numberOfPairsToConnect: 10) == 40)
    }
    
    @Test func `the sizes of the three largest circuits multiplied together for the actual input should be 103488`() {
        #expect(part1(input, numberOfPairsToConnect: 1000) == 103488)
    }
}
