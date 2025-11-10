from typing import List

class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        if not nums:
            return 0
        k = 0
        prev = None
        prev_freq = 0
        for i in range(len(nums)):
            if nums[i] != prev:
                prev = nums[i]
                nums[k] = prev
                k += 1
                prev_freq = 1
            elif prev_freq < 2:
                nums[k] = prev
                k += 1
                prev_freq += 1
        return k