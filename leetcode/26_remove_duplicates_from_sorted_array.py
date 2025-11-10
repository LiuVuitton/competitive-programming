from typing import List

class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        if not nums:
            return 0
        k = 0
        prev = None
        for i in range(len(nums)):
            if nums[i] != prev:
                nums[k] = nums[i]
                prev = nums[k]
                k += 1
        return k