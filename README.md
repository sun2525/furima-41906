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
- has_many :comments
- has_many :purchases

---

### Items テーブル

| Column              | Type       | Options                        |
|---------------------|------------|--------------------------------|
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| shipping_fee       | string     | null: false                    |
| prefecture         | string     | null: false                    |
| shipping_days      | string     | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- has_many :comments
- has_one :purchase

---

### Comments テーブル

| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| content    | text       | null: false                    |
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :item

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
| address_line1  | string     | null: false                    |
| address_line2  | string     |                                |
| phone_number   | string     | null: false                    |
| purchase       | references | null: false, foreign_key: true |

#### Association

- belongs_to :purchase