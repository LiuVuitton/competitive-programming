#include <string>
#include <iostream>
#include <cstdint>
using namespace std;

int main() {
    string name;
    cin >> name;
    uint32_t alphabet = 0;
    for (char c : name) {
        int idx = (c <= 'z' ? c - 'a' : c - 'A');
        alphabet |= (1 << idx);
    }

    if (__builtin_popcount(alphabet) & 1)
        cout << "IGNORE HIM!\n";
    else
        cout << "CHAT WITH HER!\n";

    return 0;
}