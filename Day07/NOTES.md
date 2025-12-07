# AoC Day 07 - 📝 Notes from the journey 🍅 by 🍅

## 🏷️ Labels

- ✅ done
- 🚧 WIP
- ❌ ERROR
- ⚠️ TODO


- ✅ Part one was easy enough: go row by row while keeping a tally of active beams, number of times a beam splits and check what happens to those beams.
- ✅ Part two was a bit tougher. I considered several approaches
    - ❌ Recursive: try and find the way 'back up' starting from the bottom. The idea was to split the problem into smaller problems and then use memoization for performance. However, was not able to get the correct result.
    - ❌ While instering into beam, keep duplicates. Didn't implement this one.
    - ✅ After doing some pen and paper examples, I found I could a track of how strong a beam is. I.e. multiple paths would be a stronger beam. And using this value to imprint a value into a result matrix whereever a beam comes.
