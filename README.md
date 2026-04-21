# KLParkEasy Smart Parking Database System

## 📋 プロジェクト概要

KLParkEasyは、クアラルンプール市内の5つの主要エリア（KL Sentral, Jalan Ampang, Bukit Bintang, Cyberjaya, The Gardens Mall）で展開される、AI統合型スマート駐車プラットフォームです。本プロジェクトでは、このシステムを支えるリレーショナルデータベースを設計・実装しました。

### 主な機能
- クライアント管理（Individual / Corporate）
- 車両管理（EV車両の識別を含む）
- 駐車場・駐車スポット管理
- 動的価格設定（Dynamic Pricing Rules）
- ロイヤリティプログラム（ParkPoints Elite）
- ブランド管理（KLParkEasy Pro / Tourist）
- スタッフ管理とメンテナンス履歴
- リファラルボーナスシステム

---

## 🗄️ データベース構造（主要テーブル）

| テーブル名 | 説明 |
|---|---|
| `client` | クライアント情報（Individual/Corporate） |
| `individualclient` / `corporateclient` | クライアントのサブタイプ |
| `brand` / `clientbrand` | ブランド管理とM:N関連 |
| `vehicle` / `evvehicle` / `nonevvehicle` | 車両とEV/非EVサブタイプ |
| `parkinglot` / `parkingspot` | 駐車場と駐車スポット |
| `parkingsession` | 駐車セッション取引（40+レコード） |
| `dynamicpricingrule` / `appliedsurcharge` | 動的価格ルール |
| `applieddiscount` | 適用された割引 |
| `pointearning` / `pointredemption` | ポイント獲得・使用履歴 |
| `referralbonus` | リファラルボーナス |
| `staff` / `technician` / `manager` / `attendant` / `financeofficer` | スタッフ管理 |
| `maintenanceaction` | メンテナンス履歴 |

---

## 🎯 授業の振り返り（ER図作成担当として）

### 担当範囲
私はこのプロジェクトで **Entity-Relationship Diagram (ERD) の設計** を担当しました。ケーススタディを読み解いてエンティティとリレーションシップを抽出し、draw.io で ERD / EER / Physical Model の3つを作図する役割です。

<img width="976" height="766" alt="image" src="https://github.com/user-attachments/assets/84a10fda-1932-4fa8-a079-1e2fa20afaf2" />
<img width="974" height="581" alt="image" src="https://github.com/user-attachments/assets/e5365d55-6c56-4a2c-bfc4-22cd914158ae" />


### 一番苦労したこと: classとentityの区別

ER図を作成するとき、**「これはクラス（概念上のまとまり）として扱うべきか、それともエンティティ（DBの1テーブル）として切り出すべきか」の判断が一番難しかった** です。オブジェクト指向の授業で習った「クラス」と、データベース設計の「エンティティ」は似ているようで目的がちがうため、最初は頭の中で混ざってしまいました。

具体的に迷った例:

#### 例1: `ParkPoints` は属性かエンティティか
最初は「ParkPoints は Client の持ち物だから Client の属性でいい」と考えました。これはオブジェクト指向的な発想（Client クラスのフィールド）です。しかし要件を読み直すと「獲得日時・使用日時の履歴を追跡する」とあり、これは **1対多の履歴データ** なので、独立したエンティティとして切り出す必要がありました。結果、`ParkPointsBalance` は Client の属性として残しつつ、`PointEarning` と `PointRedemption` を別エンティティにしました。

→ **学び:** クラスの属性は「現在の状態」、エンティティは「状態の変化の記録」として考えるべきだと気づきました。


### class と entity の違いで整理できたこと

最終的に、自分の中で以下のように整理しました:

| 観点 | Class（OOP） | Entity（DB） |
|---|---|---|
| 主目的 | 振る舞い（メソッド）を含む設計 | データの保存と整合性 |
| 履歴 | 必要に応じて別クラスで持つ | 履歴が必要なら別エンティティに分離 |
| 継承 | そのまま継承できる | EERでサブタイプ、物理では別テーブル |
| 関係の多重度 | 参照やコレクションで表現 | PK/FK と関連エンティティで表現 |
| ロジック | メソッドで表現 | ビジネスルールは別エンティティ化することも |

この区別が頭の中でつながってから、ER図がぐっと描きやすくなりました。


### 自分なりの気づき

データベース設計は「正解がひとつではない」ことを実感しました。同じ要件でも、継承を使うか・しないか、M:N を別テーブルにするか・しないかなど、複数の設計が成り立ちます。**重要なのは設計に一貫した理由があり、チーム全員が理解できる形になっていること** だと学びました。


## 📊 実装したクエリ概要

### Part C: 指定クエリ（6問）
1. KLParkEasy Pro ブランドの Corporate EV 所有者一覧
2. Bukit Bintang ゾーンの総 BaseCharge 収益
3. センサーが Offline のスポット一覧
4. Gold Tier ユーザーの FinalCharge 計算（3時間・Peak Hour・20%サーチャージ）
5. LPR 失敗セッションのゾーン別集計
6. Blockchain Token 支払い客の ParkPoints Top 10

### Part D: 分析レポート（5種）
1. **ロイヤリティ別収益レポート**（JOIN + GROUP BY）
2. **トップ10顧客（生涯収益）**（複数 JOIN + LIMIT）
3. **ピーク/オフピーク収益比較**（CASE WHEN + SUM）
4. **平均駐車時間が全体平均を上回る顧客**（ネストクエリ + HAVING）
5. **ゾーン別パフォーマンスサマリー**（集計関数組み合わせ）

### Part E: 洪水警報ディスカウント機能
- `FloodRiskLevel` カラムの追加
- `floodriskevent` テーブルの新規作成
- BEFORE INSERT トリガーによる自動50%割引適用


---

## 🔗 使用したツール

- **draw.io** — ERD / EER / Physical Model の作図
- **MySQL Workbench** — 物理モデルの確認と SQL 実装検証
- **Google Docs** — チーム内共有と進捗管理
