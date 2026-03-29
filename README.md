# Project Hanoji

## 概要
手首や腕の負担を軽減する、八の字型（回外姿勢）のレバーレスコントローラー開発プロジェクト。

## 目標
- エルゴノミクスに基づいた操作性の高いコントローラーの開発
- 製品化および販売

## ディレクトリ構成
- `marketing/sns/`: SNS発信（投稿案・スケジュール管理）
- `marketing/strategy/`: 戦略立案（市場調査・競合分析・販売戦略）
- `marketing/product/`: 商品企画（仕様書・ロードマップ）
- `content/`: コンテンツ（ブログ記事・SNS投稿案・画像素材）
- `docs/`: ドキュメント（試作仕様・Deep Research）

## エージェント起動方法（Claude Code）

各ディレクトリで `claude` を起動すると、専用の指示（CLAUDE.md）が自動で読み込まれます。

| やりたいこと | 起動コマンド |
|------------|------------|
| SNS投稿を作りたい | `cd marketing/sns && claude` |
| 商品企画・試作仕様を進めたい | `cd marketing/product && claude` |
| 市場調査・戦略を考えたい | `cd marketing/strategy && claude` |
| ブログ記事を書きたい | `cd content && claude` |

複数タブで同時に起動することで、並列に作業できます。

## ドキュメント
- 競合調査（2026-01-14）: `docs/deepresearch/market_strategy/competitive_research_2026-01-14.md`
- Deep Research INDEX: `docs/deepresearch/INDEX.md`
