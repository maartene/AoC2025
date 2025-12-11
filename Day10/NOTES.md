# AoC Day 10 - 📝 Notes from the journey 🍅 by 🍅

## 🏷️ Labels

- ✅ done
- 🚧 WIP
- ❌ ERROR
- ⚠️ TODO

- Just to give it a go, I tried using a Monte Carlo approach for part 1. And that one actually ended up working! Color me surprised.
- For part 2 I rather quickly had an algorithm that would eventually find the solution. 
    - It worked for the example input
    - However, this one was impractical for the actual input
    - I tried various optimization:
        - Mostly other data structures (which already improved a bit)
        - Also Monte Carlo (but did not yield any results)
    - On Reddit I learned that the regular way of solving these kinds of issues is through Linear Programming. In particular a linear programming library called Z3 for Python. I ended up asking CoPilot for suggestions. And that tried a greedy algorithm (didn't work) and then a helper script (calling it from Swift) in Python. A bit of a dirty approach, but at least it worked.