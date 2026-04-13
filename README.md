# Rails 8 Encrypted Recipes

[![Ruby 3.2.6](https://img.shields.io/badge/Ruby-3.2.6-CC342D?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Rails 8.1](https://img.shields.io/badge/Rails-8.1-CC0000?logo=rubyonrails&logoColor=white)](https://rubyonrails.org/)
[![CI](https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes/actions/workflows/ci.yml/badge.svg)](https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

English | [Tiếng Việt](README.vi.md)

Rails 8 Encrypted Recipes is a demo CRUD application that shows how to use Active Record Encryption in a real Rails app, including deterministic encryption for searchable fields and encrypted foreign keys in join tables.

The project uses a recipe management domain with categories, recipes, ingredients, steps, tags, profile management, and authentication powered by Devise. It also includes a Bootstrap-based admin UI, Turbo-powered dashboard widgets, sample seed data, system tests with Capybara + Selenium, and a production-oriented Docker image.

## Table of Contents

- [What This Project Demonstrates](#what-this-project-demonstrates)
- [Screenshots](#screenshots)
- [Stack](#stack)
- [Domain Model](#domain-model)
- [Encryption Coverage](#encryption-coverage)
- [Features Available in the UI](#features-available-in-the-ui)
- [Local Setup](#local-setup)
- [Seed Data and Default Login](#seed-data-and-default-login)
- [Running with Docker](#running-with-docker)
- [Tests and Quality Checks](#tests-and-quality-checks)
- [Password Reset and Mail Delivery](#password-reset-and-mail-delivery)
- [Notes From the `manual/` Folder](#notes-from-the-manual-folder)
- [Troubleshooting](#troubleshooting)
- [References](#references)
- [License](#license)

## What This Project Demonstrates

- Active Record Encryption on business fields such as recipe names, summaries, descriptions, and numeric values.
- Deterministic encryption for fields that must still support lookups or grouping.
- Encrypted foreign keys on join models such as `ingredient_recipes`, `recipe_tags`, and `ingredient_tags`.
- A multi-resource Rails CRUD app with authentication, password recovery, and profile management.
- A dashboard page that summarizes seeded data and renders widget content through Turbo Stream endpoints.
- A seeded demo dataset that makes the UI usable immediately after setup.

## Screenshots

The screenshot gallery has been moved to a separate document so this README stays concise.

- [Open the English screenshot gallery](docs/screenshots.md)
- [Open the Vietnamese screenshot gallery](docs/screenshots.vi.md)

Screenshot filenames in `screenshots/` have been normalized to lowercase for consistent linking on GitHub and Linux-based environments.

## Stack

| Layer | Details |
| --- | --- |
| Ruby | 3.2.6 |
| Rails | 8.1.3+ |
| Database | SQLite3 |
| Authentication | Devise |
| Frontend | ERB, Bootstrap, Turbo, Stimulus, Importmap |
| Background/runtime defaults | Solid Cache, Solid Queue, Solid Cable |
| Testing | Minitest, Capybara, Selenium WebDriver |
| Security and quality | Brakeman, RuboCop Rails Omakase |
| Packaging | Docker, Thruster, Kamal-ready image |

## Domain Model

The application centers on the following resources:

- `Category`: groups recipes such as Desserts, Salads, or Main Courses.
- `Recipe`: the main entity, with cuisine, vegetarian flag, calories, duration, steps, ingredients, and tags.
- `Ingredient`: reusable ingredient definitions with descriptions.
- `Step`: ordered preparation steps for a recipe.
- `Tag`: reusable labels for either recipes or ingredients.
- `IngredientRecipe`: join model that stores amount and unit for an ingredient used in a recipe.
- `RecipeTag`: join model that connects recipes and tags.
- `IngredientTag`: join model that connects ingredients and tags.
- `User` and `Profile`: Devise-based authentication and account management.

## Encryption Coverage

This repository encrypts far more than a single demo column. The current model layer uses the following approach:

| Model | Encrypted fields |
| --- | --- |
| `Category` | `name` (deterministic), `summary` |
| `Recipe` | `name` (deterministic), `summary`, `category_id` (deterministic), `cuisine_type` (deterministic), `prepare_duration` (deterministic), `calories`, `is_vegetarian` |
| `Ingredient` | `name` (deterministic), `description` |
| `Step` | `description`, `step_number` (deterministic), `recipe_id` (deterministic) |
| `Tag` | `name` (deterministic) |
| `IngredientRecipe` | `ingredient_id` (deterministic), `recipe_id` (deterministic), `amount`, `unit` |
| `RecipeTag` | `recipe_id` (deterministic), `tag_id` (deterministic) |
| `IngredientTag` | `ingredient_id` (deterministic), `tag_id` (deterministic) |

### Important design note

Encrypted foreign keys in join tables are useful for protecting relational data, but they also make plain SQL joins against unencrypted primary keys unreliable. For that reason, the app resolves some cross-table relations through direct join-model queries and helper loaders instead of relying on `has_many :through` everywhere.

That is why you will see manual loaders such as `ingredients`, `tags`, `recipes`, `ingredients_list`, and `preload_ingredient_recipes` in the model layer.

## Features Available in the UI

- Login, sign up, password reset, remember-me, and profile update flows.
- Dashboard widgets for totals, latest recipes, top ingredient tags, recipe tags, and cuisine breakdowns.
- CRUD pages for categories, recipes, ingredients, steps, tags, and ingredient-recipe assignments.
- Per-recipe step management and per-recipe ingredient management.
- Tagging for both recipes and ingredients.
- Delete confirmation modals and success flash messages.

## Local Setup

### 1. Clone the repository

```bash
git clone https://github.com/dangkhoa2016/Rails-8-Encrypted-Recipes.git
cd Rails-8-Encrypted-Recipes
```

### 2. Install gems

```bash
bundle install
```

### 3. Create a local `.env` file

The project includes `dotenv-rails` for development and test. You can start from the sample file:

```bash
cp .env.sample .env
```

Current sample values:

```env
RAILS_LOG_TO_STDOUT=true
RAILS_ENV=development
PORT=4000
RAILS_MAX_THREADS=1
```

### 4. Configure Rails credentials

Generate encryption keys:

```bash
bin/rails db:encryption:init
```

Then open credentials and add the generated values:

```bash
bin/rails credentials:edit
```

Recommended structure:

```yaml
secret_key_base: your_secret_key_base

admin_email: your-admin@example.com
admin_password: your-strong-password

active_record_encryption:
  primary_key: your_primary_key
  deterministic_key: your_deterministic_key
  key_derivation_salt: your_key_derivation_salt
```

Notes:

- In `development`, the seed script falls back to a default admin account if `admin_email` and `admin_password` are not provided.
- In non-development environments, the admin account should be provided through credentials or environment variables.
- You can also use environment-specific credentials under `config/credentials/<environment>.yml.enc`.

### 5. Prepare the database

```bash
bin/rails db:prepare
bin/rails db:seed
```

### 6. Start the application

```bash
bin/rails server
```

If you keep the sample `.env`, the app will be available at `http://localhost:4000`.

## Seed Data and Default Login

The seed pipeline loads dedicated files under `db/seeds/` for categories, recipes, tags, ingredients, join tables, steps, and the admin user.

After `bin/rails db:seed`, the demo dataset includes:

- 10 categories
- 20 recipes
- 20 tags split across recipe tags and ingredient tags
- 18 ingredients
- recipe-step records and ingredient-recipe links
- one admin user

Default development login:

- Email: `admin@admin.admin`
- Password: `adminadmin`

In production-like environments, the admin account can be created from:

- `ADMIN_EMAIL` and `ADMIN_PASSWORD`
- or `admin_email` and `admin_password` stored in Rails credentials

## Running with Docker

The included Dockerfile is aimed at a production-like container image and starts the app through Thruster on port `80`.

### Build the image

```bash
docker build -t rails_8_encrypted_recipes .
```

### Run the container

```bash
docker run -d \
  -p 4000:80 \
  -e RAILS_MASTER_KEY="$(cat config/master.key)" \
  -e ADMIN_EMAIL="admin@admin.admin" \
  -e ADMIN_PASSWORD="adminadmin" \
  --name rails_8_encrypted_recipes \
  rails_8_encrypted_recipes
```

### Prepare and seed the database inside the container

```bash
docker exec -it rails_8_encrypted_recipes bin/rails db:prepare
docker exec -it rails_8_encrypted_recipes bin/rails db:seed
```

Useful container commands collected from the project notes:

```bash
docker logs -f rails_8_encrypted_recipes
docker exec -it rails_8_encrypted_recipes bash
docker stop rails_8_encrypted_recipes
```

## Tests and Quality Checks

### Application tests

```bash
bin/rails test
```

### System tests

```bash
bin/rails test:system
```

System tests use Capybara + Selenium. You need Chrome or Chromium and a matching driver available on the machine.

One straightforward setup, taken from the project notes, is:

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get update
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
```

### Linting

```bash
bundle exec rubocop
```

### Security scan

```bash
bundle exec brakeman
```

## Password Reset and Mail Delivery

The password reset UI is available because Devise `:recoverable` is enabled. To actually send reset emails outside a development/test shortcut flow, configure Action Mailer for the target environment.

## Notes From the `manual/` Folder

The repository includes a `manual/` folder with scratch notes that were used while building and validating the app. The most relevant files are:

- `manual/docker.txt`: sample Docker build, run, copy, and exec commands.
- `manual/install-chrome.sh`: browser installation notes for system testing.
- `manual/scaffold.txt`: the original scaffold commands for the main resources.
- `manual/encrypt.rb` and `manual/associations.rb`: console snippets used to verify encryption and associations.
- `manual/devise.rb`: quick Devise console snippets for password validation and reset instructions.

These files are helpful as implementation notes, but the README should be the primary source for normal setup and usage.

## Troubleshooting

| Problem | What to check |
| --- | --- |
| `ActiveRecord::Encryption::Errors::Decryption` | The active environment is using the wrong encryption keys. Re-check Rails credentials and `RAILS_MASTER_KEY`. |
| Missing admin user after seeding | Ensure `db:seed` ran successfully and, outside development, provide `ADMIN_EMAIL` and `ADMIN_PASSWORD` or the equivalent credentials entries. |
| Password reset email is not delivered | Configure Action Mailer for the current environment. The UI alone is not enough to send emails. |
| System tests fail because no browser is available | Install Chrome or Chromium and a matching driver before running `bin/rails test:system`. |
| Container boots but app data is missing | Run `bin/rails db:prepare` and `bin/rails db:seed` inside the container. |

## References

- [Rails Guides: Active Record Encryption](https://guides.rubyonrails.org/active_record_encryption.html)
- [Devise](https://github.com/heartcombo/devise)
- [Kamal](https://kamal-deploy.org)

## License

This project is licensed under the [MIT License](LICENSE).