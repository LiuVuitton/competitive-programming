from typing import List

class Solution:
    def canJump(self, nums: List[int]) -> bool:
        ub = 0
        n = len(nums)
        for i in range(n):
            if i > ub:
                break
            ub = max(ub, i + nums[i])
        return ub >= n - 1
