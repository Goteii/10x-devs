# 10x-cards

A web application for quickly creating and managing educational flashcards with AI assistance. 10x-cards leverages Large Language Models to generate flashcard suggestions from user-provided text, making the learning process more efficient.

## Table of Contents

- [10x-cards](#10x-cards)
  - [Table of Contents](#table-of-contents)
  - [Tech Stack](#tech-stack)
    - [Frontend](#frontend)
    - [Backend](#backend)
    - [AI Integration](#ai-integration)
    - [CI/CD \& Hosting](#cicd--hosting)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Available Scripts](#available-scripts)
  - [Project Scope](#project-scope)
    - [Core Features](#core-features)
    - [Success Metrics](#success-metrics)
    - [Out of Scope for MVP](#out-of-scope-for-mvp)
  - [Project Status](#project-status)
  - [License](#license)

## Tech Stack

### Frontend

- **Astro 5.5.5**: Fast, efficient pages with minimal JavaScript
- **React 19.0.0**: For interactive components
- **TypeScript**: Static typing for better code quality and IDE support
- **Tailwind CSS 4.0.17**: Utility-first CSS framework
- **Shadcn/ui**: Accessible React component library

### Backend

- **Supabase**: Comprehensive backend solution providing:
  - PostgreSQL database
  - SDK for multiple languages (Backend-as-a-Service)
  - Built-in user authentication
  - Open-source solution that can be self-hosted

### AI Integration

- **Openrouter.ai**: API service providing access to various LLM models:
  - OpenAI, Anthropic, Google and other models
  - Financial limit settings for API keys

### CI/CD \& Hosting

- **GitHub Actions**: CI/CD pipelines
- **DigitalOcean**: Application hosting via Docker

## Getting Started

### Prerequisites

- Node.js 22.14.0
- Git

### Installation

1. Clone the repository:

```bash
git clone https://github.com/goteii/10x-devs.git
cd 10x-devs
```

2. Install dependencies:

```bash
npm install
```

3. Set up environment variables:
   Create a `.env` file in the root directory with the following variables:

```
# Supabase configuration
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_anon_key

# OpenRouter.ai API key
OPENROUTER_API_KEY=your_openrouter_api_key
```

4. Start the development server:

```bash
npm run dev
```

5. Open your browser and navigate to `http://localhost:3000`

## Available Scripts

- `npm run dev` - Start the development server
- `npm run build` - Build the application for production
- `npm run preview` - Preview the production build locally
- `npm run astro` - Run Astro CLI commands
- `npm run lint` - Run ESLint to check for code issues
- `npm run lint:fix` - Run ESLint and automatically fix issues
- `npm run format` - Format code with Prettier

## Project Scope

10x-devs is designed to solve the problem of time-consuming manual flashcard creation by leveraging AI to generate high-quality learning materials.

### Core Features

1. **AI-Powered Flashcard Generation**
   - Users can paste text (e.g., textbook excerpts)
   - AI suggests flashcards (questions and answers)
   - Users can accept, edit, or reject suggestions
2. **Manual Flashcard Management**
   - Create flashcards manually
   - Edit and delete existing flashcards
   - View all flashcards in "My Flashcards" section
3. **User Authentication**
   - Registration and login
   - Account and data deletion on request
4. **Spaced Repetition Learning**
   - Integration with spaced repetition algorithm
   - Learning sessions with flashcard review
5. **Data Storage \& Security**
   - Secure storage of user data and flashcards
   - GDPR compliance

### Success Metrics

- 75% of AI-generated flashcards accepted by users
- At least 75% of all new flashcards created using AI

### Out of Scope for MVP

- Advanced custom spaced repetition algorithm
- Gamification features
- Mobile applications
- Document import (PDF, DOCX, etc.)
- Public API
- Flashcard sharing between users
- Advanced notification system
- Advanced keyword search

## Project Status

This project is currently in development. MVP features are being implemented.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
