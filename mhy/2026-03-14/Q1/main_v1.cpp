#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> matrix(n, vector<int>(m));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> matrix[i][j];
        }
    }

    vector<int> rowSum(n, 0);
    vector<int> colSum(m, 0);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            rowSum[i] += matrix[i][j];
        }
    }

    for (int j = 0; j < m; j++) {
        for (int i = 0; i < n; i++) {
            colSum[j] += matrix[i][j];
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (rowSum[i] == colSum[j]) {
                result++;
            }
        }
    }

    cout << result << "\n";


    return 0;
}
