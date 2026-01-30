---
allowed-tools: Bash(gh pr:*), Bash(gh api:*), Bash(git:*), Task
description: 教育的なPRレビュー（なぜそうすべきかを丁寧に説明）
---

## Context

- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`

## Your task

初心者に教えることを目的としたPRレビューを行います。

### 手順

1. まず `code-review:code-review` エージェント（Task tool）を使ってPRの技術的な問題点を検出

2. 検出された各問題に対して、以下の情報を追加して教育的なコメントを作成:
   - **なぜ問題か**: 初心者にも分かる説明
   - **実務での重要性**: 現場でどう影響するか、なぜ学ぶべきか
   - **修正例**: 具体的なコード例（Before/After の diff 形式）
   - **参考リンク**: 公式ドキュメントや信頼できる記事

3. `gh pr comment` でPRにコメントを投稿

### 出力フォーマット

```markdown
### 良い点
- （良い点があれば褒める）

### 改善点

#### 1. [問題のタイトル]

**何が問題か**
（問題の説明）

**なぜ重要か**
（実務でどう役立つか、なぜ学ぶべきか）

**修正例**
```diff
- 修正前のコード
+ 修正後のコード
```

**参考**
- [リンクタイトル](URL)

---

🤖 Generated with [Claude Code](https://claude.ai/code)
```

### トーン
- 批判ではなく教育的に
- 「〜した方がいいよ！」のような親しみやすさ
- 良い点は積極的に褒める
- 「なぜ」を必ず説明する
