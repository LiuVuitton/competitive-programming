#include <string>
#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    string op;
    int value = 0;
    for (int i = 0; i < n; ++i) {
        cin >> op;
        value += (op[1] == '+' ? 1 : -1);
    }
    cout << value << "\n";
    return 0;
}