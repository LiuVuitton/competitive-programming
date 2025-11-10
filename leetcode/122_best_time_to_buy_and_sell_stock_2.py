from typing import List

class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if not prices or len(prices) < 2: 
            return 0
        prev = prices[0]
        profit = 0
        for price in prices:
            gain = price - prev
            prev = price
            if gain > 0:
                profit += gain
        return profit