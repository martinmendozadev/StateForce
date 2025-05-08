# StateForce

### Real-time Emergency Resource Management

StateForce is a Ruby on Rails application focused on optimizing emergency response resources in real-time. It is intended for use by the CENTRO DE ENLACE Y COMUNICACIONES (CECOM) at a state level. The system integrates user authentication, job processing, caching, and modern frontend tools to deliver a robust operational platform.

---

## Ruby version

**3.4.3**

> You can install it with [`rbenv`](https://github.com/rbenv/rbenv):  
> `rbenv install 3.4.3 && rbenv global 3.4.3`

---

## System dependencies

- [Rails 8.0.2](https://rubyonrails.org/)
- [PostgreSQL 17](https://www.postgresql.org/)
- [Redis](https://redis.io/)
- [Node.js and Yarn](https://classic.yarnpkg.com/lang/en/docs/install/)
- [TailwindCSS](https://tailwindcss.com/)
- [Hotwire (Turbo + Stimulus)](https://hotwired.dev/)
- [Sidekiq](https://sidekiq.org/)
- [Devise](https://github.com/heartcombo/devise)
- [OmniAuth (Google OAuth2)](https://github.com/zquestz/omniauth-google-oauth2)
- [RuboCop](https://github.com/rubocop/rubocop)

---

## Configuration

1. Copy `.env.sample` to `.env` and fill in the required values:

   ```bash
   cp .env.sample .env
   ```

2. Install dependencies:

   ```bash
   bundle install
   yarn install
   ```

3. Set up database and environment:
   ```bash
   bin/setup
   ```

---

## Database creation

```bash
rails db:create
```

## Database initialization

```bash
rails db:migrate
rails db:seed
```
