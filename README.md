## データベース設計

### Users テーブル

| Column              | Type   | Options                   |
|---------------------|--------|---------------------------|
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_kana      | string | null: false               |
| first_name_kana     | string | null: false               |
| birthday            | date   | null: false               |

#### Association

- has_many :items
- has_many :purchases

---

### Items テーブル
| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    | # ActiveHash
| condition_id       | integer    | null: false                    | # ActiveHash
| shipping_fee_id    | integer    | null: false                    | # ActiveHash
| prefecture_id      | integer    | null: false                    | # ActiveHash
| shipping_days_id   | integer    | null: false                    | # ActiveHash
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |


#### Association

- belongs_to :user
- has_one :purchase


---

### Purchases テーブル

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :item
- has_one :address

---

### Addresses テーブル

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| postal_code    | string     | null: false                    |
| prefecture     | string     | null: false                    |
| city           | string     | null: false                    |
| street_address | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| purchase       | references | null: false, foreign_key: true |

#### Association

- belongs_to :purchase