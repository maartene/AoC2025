# AoC Day 11 - 📝 Notes from the journey 🍅 by 🍅

## 🏷️ Labels

- ✅ done
- 🚧 WIP
- ❌ ERROR
- ⚠️ TODO

- Part 1 was very easy / very quick to solve using a BFS
- Part 2 was trickyer. 
    - Although creating an algorithm that will eventually find the answer was not very difficult: just multiply from svr -> fft * fft -> dac * dac -> out together
    - However the sheer amount of possible paths in the actual input was just too big
    - Even when splitting up the searches
    - I needed CoPilot to suggest a recursive BFS algorithm with memoization to cache results.
