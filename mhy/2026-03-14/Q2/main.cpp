#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // read input
    int n;

    cin >> n;

    vector<int> height(n);

    for (int i = 0; i < n; i++) {
        cin >> height[i];
    }

    // solve
    // 在递增的区间，删除中间的元素，保留两端的元素
    int keep = 1;
    int pre = 0;
    
    int cur = 0;        // height[i] 和 height[i-1] 的差值符号
    for (int i = 1; i < n; i++) {
        if (height[i] - height[i-1] > 0) {
            cur = 1;
        }else if (height[i] - height[i-1] < 0) {
            cur = -1;
        }else {
            cur = 0;
        }

        if (cur == 0) continue;
        if (pre == 0 || pre * cur < 0) {
            keep++;
            pre = cur;
        }
    }

    // output
    cout << n - keep << '\n';

    return 0;
}
