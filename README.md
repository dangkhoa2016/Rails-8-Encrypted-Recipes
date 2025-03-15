# Rails 8 Data Encryption Demo Project

## Introduction

This project is a simple example of how to use **Rails 8 Active Record Encryption** to encrypt data, including encrypting foreign keys, in a `Recipes` management application. It demonstrates how to apply the built-in encryption feature in Rails 8 to protect sensitive information.

Rails encryption helps secure data stored in the database without changing how you work with Active Record, while ensuring the protection of recipe information, `Ingredients`, or `Recipes`.

## Features

- Encrypt sensitive attributes in the `Recipe` model.
- Encrypt foreign keys linking to other tables to ensure the security of related data.
- Utilize Rails 8’s Active Record Encryption feature to automate the encryption and decryption process.
- Provide a friend to add, update, and query recipes.
- Using Bootstrap 5.3 for styling.
- Using Capybara and Selenium for integration testing.
- Using Devise for authentication and authorization.

## Installation

1. Clone the repository to your machine:
   ```bash
   git clone https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes.git
   cd Rails-8-Encrypted-Recipes
   ```

2. Install the dependencies:
   ```bash
   bundle install
   ```

3. Configure encryption in `config/initializers/active_record_encryption.rb` (as per the Rails guide):
   ```ruby
   Rails.application.config.active_record_encryption = {
     primary_key: Rails.application.credentials.dig(:active_record_encryption, :primary_key),
     deterministic_key: Rails.application.credentials.dig(:active_record_encryption, :deterministic_key),
     key_derivation_salt: Rails.application.credentials.dig(:active_record_encryption, :key_derivation_salt)
   }
   ```
   or create the secret .enc and .key pair for each environment (test, development, production) at `config/credentials`

4. Create and migrate the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

   and optionally seed the database with sample data:
   ```bash
   rails db:seed
   ```
   please have a look at `db/seeds.rb` to see how the data is encrypted and decrypted.

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
