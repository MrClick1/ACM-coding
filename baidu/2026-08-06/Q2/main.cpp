#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // read input
    int q;
    cin >> q;

    // solve
    for (int i = 0; i < q; i++) {
        long long m;
        cin >> m;
        
        // 计算 y XOR (m-y) 的最小值
        // 等价于计算 y & (m-y) 的最大值
        // 直觉上两个越接近 & 的结果越大
        if (m % 2 == 0) {
            cout << 0 << "\n";
        }else {
            // m 为奇数，划分为一个 (m+1) / 2 和一个 (m-1) / 2
            long long y = (m+1) / 2;
            long long z = (m-1) / 2;
            cout << (y ^ z) << "\n"; 
        }
    }


    return 0;
}
