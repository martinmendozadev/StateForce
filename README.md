# 🚨 StateForce

**Real-time Emergency Resource Management**

StateForce is a Ruby on Rails application designed to optimize emergency response resources in real-time. Built for use by the **Centro de Enlace y Comunicaciones (CECOM)** at the state level, the system centralizes the management of medical, police, rescue, and fire department assets to reduce response times and improve coordination.

---

## 📚 Table of Contents

1. [Overview](#-overview)
2. [Tech Stack](#-tech-stack)
3. [Getting Started](#-getting-started)
4. [Development Tools](#-development-tools)
5. [Documentation](#-documentation)
6. [Support](#-support)

---

## 🔎 Overview

StateForce empowers emergency services with a modern, reliable, and scalable platform for managing real-time resources such as ambulances, hospitals, rescue units, helicopters, and specialists. It features role-based access control, real-time updates, and seamless integration of data from public APIs.

---

## 🛠 Tech Stack

- **Ruby 3.4.3** – Elegant, powerful backend language.
- **Rails 8.0.2** – Framework optimized for developer productivity and performance.
- **PostgreSQL 17** – Reliable, production-grade relational database.
- **Redis** – Used for background jobs and caching.
- **TailwindCSS 4** – Utility-first CSS framework for rapid UI development.
- **Hotwire (Turbo + Stimulus)** – For real-time, reactive frontend experiences.
- **Devise + OmniAuth** – Secure authentication with email confirmation and Google login.
- **Sidekiq** – Background job processing.
- **RuboCop** – Code quality and style enforcement.

---

## 🚀 Getting Started

To run StateForce locally:

1. **Clone the Repository**

   ```bash
   git clone git@github.com:martinmendozadev/StateForce.git
   cd StateForce
   ```

2. **Install Ruby**

   ```bash
   rbenv install 3.4.3 && rbenv global 3.4.3
   ```

3. **Install Dependencies**

   ```bash
   bundle install
   yarn install
   ```

4. **Set Up Environment Variables**

   ```bash
   cp .env.example .env
   ```

5. **Set Up the Database**

   ```bash
   bin/setup
   ```

6. **Start the Server**

   ```bash
   bin/dev
   ```

   Visit `http://localhost:3000` to start using the app.

   > **Test credentials**
   > Email: `test@stateforce.mx`
   > Password: `123qweASD`

---

## 🧰 Development Tools

- **Run Test Suite**

  ```bash
  bin/rails test
  ```

- **Run Linter**

  ```bash
  bin/rubocop
  ```

- **System Tests (Capybara + Selenium)**

  ```bash
  bin/rails test:system
  ```

  Includes headless browser testing with screenshot support for failures.

- **Hot Reloading with Turbo**

  Frontend changes are reflected instantly thanks to Hotwire.

---

## 📖 Documentation

For full technical documentation, visit the [StateForce Wiki](https://github.com/martinmendozadev/StateForce/wiki), including:

- 🧩 Entity Model Overview
- ✨ Features and Modules
- 📡 API Integration and Endpoints
- 🚀 Deployment Guide
- 🛠 Troubleshooting
- 🤝 Contributing Guidelines
- 🧑‍💻 Code Style Guide

---

## 🤝 Support

If you run into issues or have questions:

📬 **[martinmendozadev@gmail.com](mailto:martinmendozadev@gmail.com)**

We welcome contributions and feedback to improve StateForce for emergency services everywhere.
