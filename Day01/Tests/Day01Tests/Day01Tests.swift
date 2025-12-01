import Testing
@testable import Day01

let exampleInput =
    """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """

@Suite struct `to get the first start on day 1`  {
    @Test func `the number of rotations ending on zero for the example input should be 3`() {
        let numberOfRotations = getNumberOfRotationsEndingOnZero(for: exampleInput)
        #expect(numberOfRotations == 3)
    }
    
    @Test func `the number of rotations ending on zero for the actual input should be 1118`() {
        let numberOfRotations = getNumberOfRotationsEndingOnZero(for: input)
        #expect(numberOfRotations == 1118)
    }
}

@Suite struct `to get the second star on day 1`  {
    @Test func `the number of rotations going through or ending on zero for the example input should be 6`() {
        let numberOfRotations = getNumberOfRotationsEndingOnZero(for: exampleInput, countAllZeroes: true)
        #expect(numberOfRotations == 6)
    }
    
    @Test func `the number of rotations going through or ending on zero for the actual input should be 6289`() {
        let numberOfRotations = getNumberOfRotationsEndingOnZero(for: input, countAllZeroes: true)
        #expect(numberOfRotations == 6289)
    }
}
