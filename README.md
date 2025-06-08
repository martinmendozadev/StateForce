[![Build Status](https://img.shields.io/github/actions/workflow/status/martinmendozadev/StateForce/ci.yml?branch=main)](https://github.com/martinmendozadev/StateForce/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Coverage Status](https://img.shields.io/codecov/c/github/martinmendozadev/StateForce)](https://codecov.io/gh/martinmendozadev/StateForce)
[![Ruby](https://img.shields.io/badge/Ruby-3.4.3-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0.2-red.svg)](https://rubyonrails.org/)

# 🚨 StateForce

**Real-time Emergency Resource Management**

StateForce is a Ruby on Rails application designed to optimize emergency response operations and resources in real time. Built for use by the **Centro de Enlace y Comunicaciones (CECOM)** at the state level, the system centralizes the management of medical, police, rescue, and fire department assets to reduce response times and improve coordination.

---

## 🎥 Demo

<img src="docs/demo.gif" alt="StateForce Demo" width="700"/>

> _A quick look at real-time resource management in action._

_Screenshots and more details available in the [Wiki](https://github.com/martinmendozadev/StateForce/wiki)._

---

## 📚 Table of Contents

1. [Overview](#-overview)
2. [Demo](#-demo)
3. [Quickstart](#-quickstart)
4. [Tech Stack](#-tech-stack)
5. [Getting Started](#-getting-started)
6. [Example Usage](#-example-usage)
7. [Development Tools](#-development-tools)
8. [Documentation](#-documentation)
9. [Contributing](#-contributing)
10. [Support](#-support)
11. [Internationalization](#-internationalization)
12. [Credits & Acknowledgements](#-credits--acknowledgements)
13. [License](#-license)

---

## 🔎 Overview

StateForce empowers emergency services with a modern, reliable, and scalable platform for managing real-time resources such as ambulances, hospitals, rescue units, helicopters, and specialists. It features role-based access control, real-time updates, and seamless integration of data from public APIs.

---

## ⚡ Quickstart

Want to try StateForce right now?

Then visit [stateforce.mx](http://localhost:3000) and log in as a guest user:

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

- 🧩 [Entity Model Overview](https://github.com/martinmendozadev/StateForce/wiki/DataBase)
- ✨ Features and Modules
- 🚦 [Roles Definition](https://github.com/martinmendozadev/StateForce/wiki/Roles-Definition)
- 🚀 [System Architecture](https://github.com/martinmendozadev/StateForce/wiki/System-Architecture)
- 📝 [Testing Guide](https://github.com/martinmendozadev/StateForce/wiki/Testing-Guide)
- 🧑‍💻 [Code Style Guide](https://github.com/martinmendozadev/StateForce/wiki/Style-Guide)

---

## 🤗 Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before submitting a pull request.

- Open issues for bugs or feature requests.
- Fork the repo and submit a pull request for improvements.

## 🤝 Support

If you run into issues or have questions:

📬 **[martinmendozadev@gmail.com](mailto:martinmendozadev@gmail.com)**

We welcome contributions and feedback to improve StateForce for emergency services everywhere.

## 🌐 Internationalization

StateForce currently supports Spanish and English. The interface language is primarily Spanish, reflecting its main operational context. Future versions may include more robust multi-language support. For details on current capabilities, see the [Wiki](https://github.com/martinmendozadev/StateForce/wiki).

---

## 🙏 Credits & Acknowledgements

- Developed by [martinmendozadev](https://github.com/martinmendozadev)
- Inspired by the needs of emergency services professionals.
- Built with Ruby on Rails, Hotwire, and the open source community.

## 📝 License

This project is licensed under the terms of the [MIT License](LICENSE).
