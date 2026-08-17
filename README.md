# ACM 刷题框架（C++17）

面向秋招笔试的本地 ACM/OJ 模式刷题仓库，重点训练牛客、米哈游等企业笔试环境：自己处理 `stdin` / `stdout`、编写完整 `main()`、本地编译运行测试。

## 刷题流程

```text
阅读题目
→ 分析数据范围
→ 判断复杂度
→ 编写 main.cpp
→ 编辑 input.txt
→ 本地运行
→ 检查边界
→ AC 后记录总结
```

## 两种模式

### ACM 模式（当前优先）

完整程序，自己处理输入输出：

```cpp
int main() {
    // 读 stdin
    // 求解
    // 写 stdout
    return 0;
}
```

模板：[templates/acm.cpp](templates/acm.cpp)

### LeetCode 模式

仅实现 `Solution` 类，输入输出由平台处理：

```cpp
class Solution {
public:
    // ...
};
```

模板：[templates/leetcode.cpp](templates/leetcode.cpp)

> 当前训练优先 **ACM 模式**。

## 目录结构

```text
ACM-coding/
├── README.md
├── .gitignore
├── templates/
│   ├── acm.cpp
│   └── leetcode.cpp
├── scripts/
│   └── run.ps1
└── mhy/
    ├── README.md          # 米哈游专项题单
    ├── 2026-03-14/
    │   ├── Q1/
    │   │   ├── problem.md    # 题目描述（Q1~Q3 已内置练习版，新题需粘贴）
    │   │   ├── main.cpp
    │   │   ├── input.txt
    │   │   ├── expected.txt
    │   │   └── notes.md
    │   ├── Q2/
    │   └── Q3/
    └── practice/          # 自由练习
```

## 本地编译运行

本机环境：Windows + PowerShell 5.1 + MinGW g++（已支持 C++17）。

### 方式一：脚本（推荐）

```powershell
.\scripts\run.ps1 .\mhy\2026-03-14\Q1
```

脚本会自动：

1. 编译 `main.cpp`（`-std=c++17 -O2 -Wall -Wextra`）
2. 以 `input.txt` 作为标准输入运行程序
3. 在终端显示程序输出和退出码
4. 若存在 `expected.txt`，额外显示期望输出并做简单比对

> 因为每次都解析 `<bits/stdc++.h>`，MinGW 下编译约需 20~30 秒，属正常现象。

### 方式二：手动编译运行

```powershell
g++ -std=c++17 -O2 .\mhy\2026-03-14\Q1\main.cpp -o .\mhy\2026-03-14\Q1\main.exe
cmd /c ".\mhy\2026-03-14\Q1\main.exe < .\mhy\2026-03-14\Q1\input.txt"
```

> PowerShell 5.1 不支持 `<` 输入重定向，手动跑时用 `cmd /c`，或者直接用 `run.ps1`。

## 如何开始一道新题

1. 从 [mhy/README.md](mhy/README.md) 选择题目（近期先做 `2026-03-14` 的 Q1）。
2. 若题目描述缺失，把完整题目粘贴到该题目录下的 `problem.md`（Q1~Q3 已内置重构版练习题目）。
3. 复制模板：`Copy-Item .\templates\acm.cpp .\mhy\2026-03-14\Q1\main.cpp`（新题目录先建好）。
4. 阅读题目 → 分析数据范围 → 判断复杂度，再动手写 `main.cpp`。
5. `input.txt` / `expected.txt` 已填入样例 1，可直接运行；想换样例时手动替换。
6. 运行脚本查看结果。
7. AC 后（或复盘时）在 `notes.md` 里按模板记录总结。

## 错题记录

每道题目录下都有可选的 `notes.md`，模板只包含复盘结构，不写答案：

```markdown
# 复盘

## 我的第一反应
## 最初考虑的算法
## 卡住的位置
## 正确模型
## 为什么当时没有想到
## 下次看到什么特征应该想到这个算法
## 时间复杂度
## 空间复杂度
```

## 输入文件编码

`input.txt` / `expected.txt` 建议使用 UTF-8（Windows 记事本默认即可）。
