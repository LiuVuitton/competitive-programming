#include <iostream>
#include <stack>
using namespace std;

int main() {
    int n;
    cin >> n;
    char prev_c = 0;
    char c;
    int count = 0;
    for (int i = 0; i < n; ++i) {
        cin >> c;
        if (prev_c && prev_c == c) {
            ++count;
        } else {
            prev_c = c;
        }
    }
    cout << count << "\n";

    return 0;
}