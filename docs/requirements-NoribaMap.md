# NoribaMap - 要件定義書

岡山県のGTFSデータを活用し、バス停のカバー範囲（半径100m〜1km）を円で可視化するWebツール。交通空白地域の可視化を通じて、移動課題の「見える化」を目的とする。

---

## ✅ 機能要件

- **GTFSデータの前処理**
  - 対象：岡山県内の各バス事業者（両備バス、岡電、下津井電鉄、宇野バスなど）
  - 使用ファイル：`stops.txt`（GTFS-JP）
  - PowerShell + DuckDB CLI で以下を処理
    - 停留所の重複排除（近接座標でマージ）
    - 緯度経度からGeoJSON出力
    - 各バス停に対してバッファ円（500m）を生成（複数サイズ対応）

- **可視化**
  - Kepler.glにインポート可能なGeoJSONを出力
  - ポイントレイヤー：バス停
  - ポリゴンレイヤー：各バス停のカバー範囲（バッファ円）
  - 円の半径は100m〜1000mの範囲で動的に選択可能

---

## 🎨 UI要件（NoribaMap静的Webアプリ）

- **UIデザイン**
  - シンプル・モダン・かっこいい
  - モバイルにも対応（レスポンシブ）

- **操作機能**
  - 半径選択スライダー（100m〜1000m, ステップ100m）
  - 読み込み済みのGeoJSONレイヤーを再描画（半径変更時）

- **使用技術**
  - HTML / Alpine.js / TailwindCSS（CDN）
  - Kepler.glまたはLeaflet.js（表示用途に応じて選択）

---

## 💡 技術スタック

| 項目 | 使用技術 |
|------|----------|
| データ処理 | PowerShell 7 + DuckDB CLI（Windows対応） |
| データ形式 | GeoJSON |
| フロントエンド | HTML + Alpine.js + TailwindCSS（CDN） |
| 地図可視化 | Kepler.gl（静的Webで動作） or Leaflet.js（動的制御用） |
| 公開方法 | GitHub Pagesによる無料ホスティング |

---

## 🚀 拡張機能（将来的に）

- バス停未被覆地域のハイライト
- ポリゴンの合成による「完全未カバーエリア」の抽出
- CSV出力・PDFマップ出力
- カバー率ランキング（自治体別）

---

## 📍 データ出典元

- 国土交通省オープンデータカタログ（GTFS-JP）
- 各バス事業者が提供するGTFSフィード
- 背景地図：OpenStreetMap（Kepler.glまたはLeafletベース）

