from typing import List

class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if not prices or len(prices) < 2:
            return 0

        max_profit = 0
        profit = 0
        prev = prices[0]
        for i in range(1, len(prices)):
            price = prices[i]
            if profit + price - prev >= 0:
                profit = profit + price - prev
                prev = price
            else:
                prev = price
                profit = 0
            if profit > max_profit:
                max_profit = profit
        return max_profit
