# Rails 8 Encrypted Recipes

[![Ruby 3.2.6](https://img.shields.io/badge/Ruby-3.2.6-CC342D?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Rails 8.1](https://img.shields.io/badge/Rails-8.1-CC0000?logo=rubyonrails&logoColor=white)](https://rubyonrails.org/)
[![CI](https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes/actions/workflows/ci.yml/badge.svg)](https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[English](README.md) | Tiếng Việt

Rails 8 Encrypted Recipes là một ứng dụng CRUD mẫu dùng để minh họa cách áp dụng Active Record Encryption trong một dự án Rails thực tế, bao gồm cả deterministic encryption cho các trường cần tìm kiếm và mã hóa khóa ngoại trong các bảng join.

Dự án dùng domain quản lý công thức nấu ăn với categories, recipes, ingredients, steps, tags, quản lý profile và xác thực bằng Devise. Ngoài ra còn có giao diện quản trị dùng Bootstrap, dashboard cập nhật bằng Turbo, dữ liệu mẫu để demo ngay sau khi seed, system test với Capybara + Selenium, và Docker image theo hướng production.

## Mục Lục

- [Dự Án Minh Họa Điều Gì](#overview)
- [Ảnh Chụp Màn Hình](#screenshots-vi)
- [Công Nghệ Sử Dụng](#stack-vi)
- [Mô Hình Nghiệp Vụ](#domain-model-vi)
- [Phạm Vi Mã Hóa Dữ Liệu](#encryption-vi)
- [Tính Năng Có Trong Giao Diện](#features-vi)
- [Thiết Lập Local](#setup-vi)
- [Dữ Liệu Seed Và Tài Khoản Mặc Định](#seed-vi)
- [Chạy Bằng Docker](#docker-vi)
- [Test Và Kiểm Tra Chất Lượng](#testing-vi)
- [Quên Mật Khẩu Và Gửi Email](#password-reset-vi)
- [Ghi Chú Từ Thư Mục `manual/`](#manual-vi)
- [Khắc Phục Sự Cố](#troubleshooting-vi)
- [Tham Khảo](#references-vi)
- [Giấy Phép](#license-vi)

<a id="overview"></a>
## Dự Án Minh Họa Điều Gì

- Active Record Encryption cho các trường nghiệp vụ như tên món, tóm tắt, mô tả và dữ liệu số.
- Deterministic encryption cho các trường vẫn cần lookup hoặc group.
- Mã hóa khóa ngoại trong các join model như `ingredient_recipes`, `recipe_tags` và `ingredient_tags`.
- Một ứng dụng Rails nhiều resource với authentication, quên mật khẩu và quản lý profile.
- Dashboard tổng hợp dữ liệu seed và nạp widget thông qua Turbo Stream endpoints.
- Bộ dữ liệu demo giúp có thể dùng giao diện ngay sau khi setup.

<a id="screenshots-vi"></a>
## Ảnh Chụp Màn Hình

Toàn bộ gallery ảnh đã được chuyển sang file riêng để README chính gọn hơn.

- [Mở gallery ảnh tiếng Anh](docs/screenshots.md)
- [Mở gallery ảnh tiếng Việt](docs/screenshots.vi.md)

Tên file trong thư mục `screenshots/` đã được chuẩn hóa về chữ thường để link ổn định hơn trên GitHub và môi trường Linux.

<a id="stack-vi"></a>
## Công Nghệ Sử Dụng

| Lớp | Chi tiết |
| --- | --- |
| Ruby | 3.2.6 |
| Rails | 8.1.3+ |
| Database | SQLite3 |
| Authentication | Devise |
| Frontend | ERB, Bootstrap, Turbo, Stimulus, Importmap |
| Runtime mặc định | Solid Cache, Solid Queue, Solid Cable |
| Testing | Minitest, Capybara, Selenium WebDriver |
| Bảo mật và chất lượng | Brakeman, RuboCop Rails Omakase |
| Đóng gói | Docker, Thruster, image sẵn cho Kamal |

<a id="domain-model-vi"></a>
## Mô Hình Nghiệp Vụ

Ứng dụng tập trung vào các resource sau:

- `Category`: nhóm các món ăn như Desserts, Salads hoặc Main Courses.
- `Recipe`: thực thể chính, chứa cuisine, cờ vegetarian, calories, duration, steps, ingredients và tags.
- `Ingredient`: nguyên liệu dùng lại được, có mô tả riêng.
- `Step`: các bước chế biến theo thứ tự của một recipe.
- `Tag`: nhãn dùng chung cho recipe hoặc ingredient.
- `IngredientRecipe`: join model lưu amount và unit của ingredient trong một recipe.
- `RecipeTag`: join model nối recipe và tag.
- `IngredientTag`: join model nối ingredient và tag.
- `User` và `Profile`: xác thực và quản lý tài khoản qua Devise.

<a id="encryption-vi"></a>
## Phạm Vi Mã Hóa Dữ Liệu

Repository này mã hóa nhiều hơn một cột demo đơn lẻ. Hiện tại model layer đang dùng cấu hình như sau:

| Model | Các trường được mã hóa |
| --- | --- |
| `Category` | `name` (deterministic), `summary` |
| `Recipe` | `name` (deterministic), `summary`, `category_id` (deterministic), `cuisine_type` (deterministic), `prepare_duration` (deterministic), `calories`, `is_vegetarian` |
| `Ingredient` | `name` (deterministic), `description` |
| `Step` | `description`, `step_number` (deterministic), `recipe_id` (deterministic) |
| `Tag` | `name` (deterministic) |
| `IngredientRecipe` | `ingredient_id` (deterministic), `recipe_id` (deterministic), `amount`, `unit` |
| `RecipeTag` | `recipe_id` (deterministic), `tag_id` (deterministic) |
| `IngredientTag` | `ingredient_id` (deterministic), `tag_id` (deterministic) |

### Lưu ý thiết kế quan trọng

Mã hóa khóa ngoại trong các join table giúp bảo vệ dữ liệu quan hệ, nhưng cũng làm cho join SQL trực tiếp với primary key dạng plaintext không còn đáng tin cậy. Vì vậy ứng dụng này giải quyết một số quan hệ xuyên bảng bằng truy vấn join model trực tiếp và các helper loader, thay vì dựa hoàn toàn vào `has_many :through`.

Đó là lý do bạn sẽ thấy các loader thủ công như `ingredients`, `tags`, `recipes`, `ingredients_list` và `preload_ingredient_recipes` trong model layer.

<a id="features-vi"></a>
## Tính Năng Có Trong Giao Diện

- Đăng nhập, đăng ký, quên mật khẩu, remember-me và cập nhật profile.
- Dashboard widget cho số lượng tổng, latest recipes, top ingredient tags, recipe tags và cuisine breakdowns.
- CRUD cho categories, recipes, ingredients, steps, tags và ingredient-recipe assignments.
- Quản lý steps và ingredients ngay trong từng recipe.
- Gắn tag cho cả recipe và ingredient.
- Modal xác nhận xóa và thông báo thành công.

<a id="setup-vi"></a>
## Thiết Lập Local

### 1. Clone repository

```bash
git clone https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes.git
cd Rails-8-Encrypted-Recipes
```

### 2. Cài gem

```bash
bundle install
```

### 3. Tạo file `.env`

Dự án dùng `dotenv-rails` cho môi trường development và test. Bạn có thể bắt đầu từ file mẫu:

```bash
cp .env.sample .env
```

Giá trị mẫu hiện có:

```env
RAILS_LOG_TO_STDOUT=true
RAILS_ENV=development
PORT=4000
RAILS_MAX_THREADS=1
```

### 4. Cấu hình Rails credentials

Sinh encryption keys:

```bash
bin/rails db:encryption:init
```

Sau đó mở credentials và thêm các giá trị vừa tạo:

```bash
bin/rails credentials:edit
```

Cấu trúc khuyến nghị:

```yaml
secret_key_base: your_secret_key_base

admin_email: your-admin@example.com
admin_password: your-strong-password

active_record_encryption:
  primary_key: your_primary_key
  deterministic_key: your_deterministic_key
  key_derivation_salt: your_key_derivation_salt
```

Lưu ý:

- Trong `development`, seed script sẽ dùng tài khoản admin mặc định nếu không có `admin_email` và `admin_password`.
- Trong môi trường ngoài development, nên truyền tài khoản admin qua credentials hoặc biến môi trường.
- Bạn cũng có thể dùng environment-specific credentials trong `config/credentials/<environment>.yml.enc`.

### 5. Chuẩn bị database

```bash
bin/rails db:prepare
bin/rails db:seed
```

### 6. Chạy ứng dụng

```bash
bin/rails server
```

Nếu giữ file `.env.sample`, ứng dụng sẽ chạy tại `http://localhost:4000`.

<a id="seed-vi"></a>
## Dữ Liệu Seed Và Tài Khoản Mặc Định

Quy trình seed nạp các file riêng dưới `db/seeds/` cho categories, recipes, tags, ingredients, join tables, steps và admin user.

Sau khi chạy `bin/rails db:seed`, bộ dữ liệu demo hiện có:

- 10 categories
- 20 recipes
- 20 tags chia thành recipe tags và ingredient tags
- 18 ingredients
- dữ liệu steps và ingredient-recipe links
- 1 tài khoản admin

Tài khoản development mặc định:

- Email: `admin@admin.admin`
- Password: `adminadmin`

Trong môi trường production-like, tài khoản admin có thể được tạo từ:

- `ADMIN_EMAIL` và `ADMIN_PASSWORD`
- hoặc `admin_email` và `admin_password` trong Rails credentials

<a id="docker-vi"></a>
## Chạy Bằng Docker

Dockerfile đi theo hướng container production-like và khởi động app bằng Thruster trên cổng `80`.

### Build image

```bash
docker build -t rails_8_encrypted_recipes .
```

### Chạy container

```bash
docker run -d \
  -p 4000:80 \
  -e RAILS_MASTER_KEY="$(cat config/master.key)" \
  -e ADMIN_EMAIL="admin@admin.admin" \
  -e ADMIN_PASSWORD="adminadmin" \
  --name rails_8_encrypted_recipes \
  rails_8_encrypted_recipes
```

### Chuẩn bị và seed database trong container

```bash
docker exec -it rails_8_encrypted_recipes bin/rails db:prepare
docker exec -it rails_8_encrypted_recipes bin/rails db:seed
```

Một số lệnh hữu ích, lấy từ ghi chú của dự án:

```bash
docker logs -f rails_8_encrypted_recipes
docker exec -it rails_8_encrypted_recipes bash
docker stop rails_8_encrypted_recipes
```

<a id="testing-vi"></a>
## Test Và Kiểm Tra Chất Lượng

### Test ứng dụng

```bash
bin/rails test
```

### System test

```bash
bin/rails test:system
```

System test dùng Capybara + Selenium. Bạn cần Chrome hoặc Chromium cùng driver phù hợp.

Một cách cài đơn giản, theo ghi chú của dự án:

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get update
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
```

### Lint

```bash
bundle exec rubocop
```

### Quét bảo mật

```bash
bundle exec brakeman
```

<a id="password-reset-vi"></a>
## Quên Mật Khẩu Và Gửi Email

Giao diện quên mật khẩu hoạt động vì Devise đang bật `:recoverable`. Để gửi email reset thật trong môi trường ngoài development/test, bạn cần cấu hình Action Mailer cho môi trường tương ứng.

<a id="manual-vi"></a>
## Ghi Chú Từ Thư Mục `manual/`

Repository có thư mục `manual/` chứa các ghi chú tạm được dùng trong lúc xây dựng và kiểm tra app. Những file đáng chú ý nhất là:

- `manual/docker.txt`: ví dụ về build, run, copy và exec với Docker.
- `manual/install-chrome.sh`: ghi chú cài browser cho system test.
- `manual/scaffold.txt`: các lệnh scaffold ban đầu cho các resource chính.
- `manual/encrypt.rb` và `manual/associations.rb`: snippet console để kiểm tra encryption và associations.
- `manual/devise.rb`: snippet console nhanh để kiểm tra Devise và reset password.

Các file này hữu ích như implementation notes, nhưng README nên là nguồn chính cho setup và usage thông thường.

<a id="troubleshooting-vi"></a>
## Khắc Phục Sự Cố

| Vấn đề | Cần kiểm tra |
| --- | --- |
| `ActiveRecord::Encryption::Errors::Decryption` | Môi trường hiện tại đang dùng sai encryption keys. Kiểm tra lại Rails credentials và `RAILS_MASTER_KEY`. |
| Seed xong nhưng không có admin user | Đảm bảo `db:seed` chạy thành công và, ngoài development, đã cung cấp `ADMIN_EMAIL` và `ADMIN_PASSWORD` hoặc giá trị tương ứng trong credentials. |
| Form quên mật khẩu không gửi email | Cấu hình Action Mailer cho môi trường hiện tại. Có giao diện là chưa đủ để gửi mail thật. |
| System test lỗi vì không có browser | Cài Chrome hoặc Chromium cùng driver phù hợp trước khi chạy `bin/rails test:system`. |
| Container chạy nhưng không có dữ liệu app | Chạy `bin/rails db:prepare` và `bin/rails db:seed` trong container. |

<a id="references-vi"></a>
## Tham Khảo

- [Rails Guides: Active Record Encryption](https://guides.rubyonrails.org/active_record_encryption.html)
- [Devise](https://github.com/heartcombo/devise)
- [Kamal](https://kamal-deploy.org)

<a id="license-vi"></a>
## Giấy Phép

Dự án được phát hành theo [MIT License](LICENSE).