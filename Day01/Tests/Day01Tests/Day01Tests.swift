import Testing
@testable import Day01

@Suite struct `to get the first start on day 1`  {
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
    
    @Test func `the number of rotations ending on zero for the example input should be 3`() {
        let numberOfRotations = getNumberOfRotationsEndingOnZero(for: exampleInput)
        #expect(numberOfRotations == 3)
    }
    
    // 301 is too low
    @Test func `the number of rotations ending on zero for the actual input should be 1118`() {
        let numberOfRotations = getNumberOfRotationsEndingOnZero(for: input)
        #expect(numberOfRotations == 1118)
    }}
