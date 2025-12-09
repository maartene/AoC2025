import Testing
@testable import Day09

let exampleInput =
"""
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
"""

@Suite struct `to get the first star on day 09` {
    @Test func `the largest rectangle area for the example input should be 50`() {
        #expect(largestRectangleArea(in: exampleInput) == 50)
    }
    
    @Test func `the largest rectangle area for the actual input should be 4755429952`() {
        #expect(largestRectangleArea(in: input) == 4755429952)
    }
}

@Suite struct `to get the second star on day 09` {
    @Test func `the largest rectangle area for the example input should be 24`() {
        #expect(part2(in: exampleInput) == 24)
    }
    
//    @Test func `greentile count`() {
//        let redCarpetTiles = parseInput(input)
//        let greenCarpetTiles = getGreenCarpetPositions(from: redCarpetTiles)
//        print(greenCarpetTiles.count)
//        
//    }
}
