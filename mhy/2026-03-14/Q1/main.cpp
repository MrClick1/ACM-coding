#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    long long x;        // 暂存读取数字 

    vector<long long> rowSum(n, 0);
    vector<long long> colSum(m, 0);
    unordered_map<long long, int> rowCount;
    unordered_map<long long, int> colCount;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> x;
            rowSum[i] += x;
            colSum[j] += x;
        }
    }

    for (int i = 0; i < n; i++) {
        rowCount[rowSum[i]]++;
    }

    for (int j = 0; j < m; j++) {
        colCount[colSum[j]]++;
    }

    // 计算结果
    int result = 0;
    for (const auto& [sum, count] : rowCount) {
        auto it = colCount.find(sum);
        if (it != colCount.end()) {
            result += count * it->second;
        }
    }

    cout << result << "\n";


    return 0;
}
