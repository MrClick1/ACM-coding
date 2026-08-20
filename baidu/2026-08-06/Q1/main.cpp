#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // read input
    int n;
    cin >> n;

    vector<int> v(n);
    for (int i = 0; i < n; i++) {
        int x;
        cin >> x;
        v[i] = x;
    }

    // solve
    int vMin = INT_MAX;
    int vMax = INT_MIN;
    for (int i = 0; i < n; i++) {
        vMin = min(vMin, v[i]);
        vMax = max(vMax, v[i]);
    }

    long long result = 1LL * (vMax - vMin) * n;

    // TODO: output
    cout << result;

    return 0;
}
