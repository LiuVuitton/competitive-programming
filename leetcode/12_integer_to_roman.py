class Solution:
    def intToRoman(self, num: int) -> str:
        values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        value_map = {
            1000:   "M",
            900:    "CM",
            500:    "D",
            400:    "CD",
            100:    "C",
            90:     "XC",
            50:     "L",
            40:     "XL",
            10:     "X",
            9:      "IX",
            5:      "V",
            4:      "IV",
            1:      "I"
        }
        idx = 0
        roman = ""
        while num > 0:
            if num >= values[idx]:
                roman += value_map[values[idx]]
                num -= values[idx]
            else:
                idx += 1
        return roman
