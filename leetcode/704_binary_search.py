class Solution:
    def search(self, nums: list[int], target: int) -> int:
        lo = 0
        up = len(nums) - 1
        while lo <= up:
            mid = lo + (up - lo) // 2
            if nums[mid] == target:
                return mid
            elif nums[mid] < target:
                lo = mid + 1
            else:
                up = mid - 1
        return -1
