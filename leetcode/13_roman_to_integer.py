class Solution:
    def romanToInt(self, s: str) -> int:
        if not s:
            return 0

        value_map = {
            'I': 1,
            'V': 5,
            'X': 10,
            'L': 50,
            'C': 100,
            'D': 500,
            'M': 1000
        }
        prev = value_map[s[0]]
        number = prev
        for i in range(1, len(s)):
            c = s[i]
            if prev < value_map[c]:
                number += value_map[c] - 2 * prev
            else:
                number += value_map[c]
            prev = value_map[c]
        return number