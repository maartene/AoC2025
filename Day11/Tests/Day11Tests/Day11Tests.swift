import Testing
@testable import Day11

let exampleInput =
"""
aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
"""

@Suite struct `to get the first star on day 11` {
    @Test func `the number of paths from you to out for the example input should be 5`() {
        #expect(part1(exampleInput) == 5)
    }
    
    @Test func `parsing input`() {
        let connections = parseInput(exampleInput)
        
        #expect(connections["you"] == ["bbb", "ccc"])
        #expect(connections["ccc"] == ["ddd", "eee", "fff"])
        #expect(connections["fff"] == ["out"])
    }
    
    @Test func `the number of paths from you to out for the actual input should be 5`() {
        #expect(part1(input) == 5)
    }
}
