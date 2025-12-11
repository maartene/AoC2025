import Testing
@testable import Day11

@Suite struct `to get the first star on day 11` {
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
    
    @Test func `the number of paths from you to out for the example input should be 5`() {
        #expect(part1(exampleInput) == 5)
    }
    
    @Test func `parsing input`() {
        let connections = parseInput(exampleInput)
        
        #expect(connections["you"] == ["bbb", "ccc"])
        #expect(connections["ccc"] == ["ddd", "eee", "fff"])
        #expect(connections["fff"] == ["out"])
    }
    
    @Test func `the number of paths from you to out for the actual input should be 772`() {
        #expect(part1(input) == 772)
    }
}

@Suite struct `to get the second star on day 11` {
    let exampleInput =
    """
    svr: aaa bbb
    aaa: fft
    fft: ccc
    bbb: tty
    tty: ccc
    ccc: ddd eee
    ddd: hub
    hub: fff
    eee: dac
    dac: fff
    fff: ggg hhh
    ggg: out
    hhh: out
    """
    
    @Test func `the number of valid paths from svr to out for the example input should be 2`() {
        #expect(part2(exampleInput) == 2)
    }
    
//    @Test func `gross number of connections from svr to out`() {
//        print(part2(input))
//    }
}
