# Rails 8 Data Encryption Demo Project

## Introduction

This project is a simple example of how to use **Rails 8 Active Record Encryption** to encrypt data, including encrypting foreign keys, in a `Recipes` management application. It demonstrates how to apply the built-in encryption feature in Rails 8 to protect sensitive information.

Rails encryption helps secure data stored in the database without changing how you work with Active Record, while ensuring the protection of recipe information, `Ingredients`, or `Recipes`.

## Features

- Encrypt sensitive attributes in the `Recipe` model.
- Encrypt foreign keys linking to other tables to ensure the security of related data.
- Utilize Rails 8’s Active Record Encryption feature to automate the encryption and decryption process.
- Provide a UI to add, update, and query recipes.
- Using Bootstrap 5.3 for styling.
- Using Capybara and Selenium for integration testing.
- Using Devise for authentication and authorization.

## Requirements

| Dependency | Version |
|------------|---------|
| Ruby       | 3.2.6   |
| Bundler    | 2.6.x   |
| Rails      | 8.1.x   |
| SQLite3    | 3.x     |

> **Note for system tests:** Chrome or Firefox with a matching ChromeDriver/GeckoDriver must be available. The test suite uses Capybara + Selenium in headless mode.

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes.git
cd Rails-8-Encrypted-Recipes
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Configure encryption keys

Generate encryption keys and store them in the credentials file:

```bash
bin/rails db:encryption:init   # prints keys — copy the output
bin/rails credentials:edit     # paste under :active_record_encryption
```

Expected structure inside the credentials file:

```yaml
active_record_encryption:
  primary_key: <generated_value>
  deterministic_key: <generated_value>
  key_derivation_salt: <generated_value>
```

Alternatively, create per-environment credential files at `config/credentials/<env>.yml.enc` with their corresponding `.key` files.

### 4. Create and migrate the database

```bash
bin/rails db:create db:migrate
```

Optionally seed the database with sample data:

```bash
bin/rails db:seed
```

Refer to `db/seeds.rb` to see how encrypted data is seeded.

### 5. Start the server

```bash
bin/rails server
```

## Running Tests

### Unit and controller tests

```bash
bin/rails test
```

### System tests (requires Chrome/Firefox headless)

```bash
bin/rails test:system
```

### Linting

```bash
bundle exec rubocop
```

### Security audit

```bash
bundle exec brakeman
```

## Troubleshooting

| Error | Solution |
|-------|---------|
| `Bundler::GemNotFound` | Run `bundle install` before any other command. |
| `ActiveRecord::Encryption::Errors::Decryption` | Ensure the correct encryption keys are set in credentials for the active environment. |
| Missing `secret_key_base` | Run `bin/rails credentials:edit` to generate a secret key base. |
| System tests fail with "no browser" | Install ChromeDriver: `sudo apt-get install -y chromium-driver`. |
| `db/schema.rb` conflicts after migrate | Run `bin/rails db:schema:load` to reset from the schema file. |

## Data Encryption Configuration

This project uses Active Record Encryption to encrypt attributes in the `Recipe` model and related foreign keys.

For example, in the `Recipe` model, sensitive fields such as `description` can be encrypted like this:

```ruby
class Recipe < ApplicationRecord
  encrypts :name, :summary, :calories # and more sensitive fields
end
```

Foreign keys linking to other tables, such as `Category`, can also be encrypted similarly:

```ruby
class Recipe < ApplicationRecord
  belongs_to :category
  encrypts :category_id, deterministic: true
end
```

## Usage

1. To create a new recipe:
   ```ruby
   recipe = Recipe.create(name: "Spaghetti Carbonara", summary: "Classic Italian pasta dish with creamy egg sauce, pancetta, and Parmesan.", calories: 600)
   ```

2. To query and display a recipe:
   ```ruby
   recipe = Recipe.find_by(name: "Spaghetti Carbonara")
   Recipe Load (0.2ms)  SELECT "recipes".* FROM "recipes" WHERE "recipes"."name" = '{"p":"TzNKplsDjR9HwaGPiogeJNvjag==","h":{"iv":"tA8YHAYIlHTH8gxg","at":"lNYUxagfLqOpUOHhEEpJUg=="}}' LIMIT 1 /*application='Rails8EncryptedRecipes'*/
   puts recipe.summary # Automatically encrypted and decrypted: "Classic Italian pasta dish with creamy egg sauce, pancetta, and Parmesan."
   ```

## Notes

- Ensure that you have correctly configured the encryption keys in `credentials.yml.enc` or `config/credentials/[env].yml.enc`.
- Encryption in Rails 8 only supports the algorithms and configuration provided by Rails, so you don’t need to manually handle the encryption/decryption process.

## References

- [Active Record Encryption - Rails Guides](https://guides.rubyonrails.org/active_record_encryption.html)

## License

This project is licensed under the [MIT License](LICENSE).
