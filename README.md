[![Build Status](https://img.shields.io/github/actions/workflow/status/martinmendozadev/StateForce/ci.yml?branch=main)](https://github.com/martinmendozadev/StateForce/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Coverage Status](https://img.shields.io/codecov/c/github/martinmendozadev/StateForce)](https://codecov.io/gh/martinmendozadev/StateForce)
[![Ruby](https://img.shields.io/badge/Ruby-3.4.4-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0.2-red.svg)](https://rubyonrails.org/)

# 🚨 StateForce

**Real-time Emergency Resource Management**

StateForce is a Ruby on Rails application designed to optimize emergency response operations and resources in real time. Originally developed for the **Centro Regulador de Urgencias Médicas (CRUM)** at the state level in Mexico, the system centralizes the management of medical, police, rescue, and fire department assets to reduce response times and improve coordination. It can also be adapted for use by any organization managing multiple emergency services.

---

## 🎥 Demo

<img src="docs/demo.gif" alt="StateForce Demo" width="700"/>

> _A quick look at real-time resource management in action._

_Screenshots and more details available in the [Wiki](https://github.com/martinmendozadev/StateForce/wiki)._

---

## 📚 Table of Contents

1. [Demo](#-demo)
2. [Overview](#-overview)
3. [Quickstart](#-quickstart)
4. [Tech Stack](#-tech-stack)
5. [Getting Started](#-getting-started)
6. [Development Tools](#-development-tools)
7. [Documentation](#-documentation)
8. [Contributing](#-contributing)
9. [Support](#-support)
10. [Internationalization](#-internationalization)
11. [Credits & Acknowledgements](#-credits--acknowledgements)
12. [License](#-license)

---

## 🔎 Overview

StateForce empowers emergency services with a modern, reliable, and scalable platform for managing real-time resources such as ambulances, hospitals, rescue units, helicopters, and specialists. It features role-based access control, real-time updates, and seamless integration of data from public APIs.

The application is tailored for the **Centro Regulador de Urgencias Médicas (CRUM)** but can be customized to meet the needs of other emergency response organizations across different regions.

---

## ⚡ Quickstart

Want to try StateForce right now?

Visit [stateforce.mx](http://localhost:3000) and log in

---

## 🛠 Tech Stack

- **Ruby 3.4.4** – Elegant, powerful backend language.
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
   rbenv install 3.4.4 && rbenv global 3.4.4
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

For full technical documentation, please visit the [StateForce Wiki](https://github.com/martinmendozadev/StateForce/wiki), which includes:

### **Core Topics**

- 🏠 [Home](https://github.com/martinmendozadev/StateForce/wiki/Home)
- 🛠 [Architecture Diagram](https://github.com/martinmendozadev/StateForce/wiki/Architecture-Diagram)
- 🧩 [DataBase](https://github.com/martinmendozadev/StateForce/wiki/DataBase)
- 🚦 [Roles Definition](https://github.com/martinmendozadev/StateForce/wiki/Roles-Definition)
- ✨ [System Architecture](https://github.com/martinmendozadev/StateForce/wiki/System-Architecture)
- 📝 [Testing Guide](https://github.com/martinmendozadev/StateForce/wiki/Testing-Guide)
- 👤 [Users Flow](https://github.com/martinmendozadev/StateForce/wiki/Users-Flow)
- 🎨 [Style Guide](https://github.com/martinmendozadev/StateForce/wiki/Style-Guide)

---

## 🤗 Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before submitting a pull request.

- Open issues for bugs or feature requests.
- Fork the repo and submit a pull request for improvements.

---

## 🤝 Support

If you run into issues or have questions:

📬 **[martinmendozadev@gmail.com](mailto:martinmendozadev@gmail.com)**

We welcome contributions and feedback to improve StateForce for emergency services everywhere.

---

## 🌐 Internationalization

StateForce currently supports Spanish and English. The interface language is primarily Spanish, reflecting its main operational context. Future versions may include more robust multi-language support. For details on current capabilities, see the [Wiki](https://github.com/martinmendozadev/StateForce/wiki).

---

## 🙏 Credits & Acknowledgements

- Developed by [martinmendozadev](https://github.com/martinmendozadev)
- Inspired by the needs of emergency services professionals.
- Built with Ruby on Rails, Hotwire, and the open source community.

---

## 📝 License

This project is licensed under the terms of the [Apache License 2.0](LICENSE).
