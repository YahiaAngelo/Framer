# Contributing to Framer

First off, thank you for considering contributing to Framer! It's people like you that make Framer such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by respect and professionalism. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps which reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include screenshots if possible**
- **Specify which version of the app you're using**
- **Specify your OS and device**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any alternatives you've considered**

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the code style** already present in the project
3. **Write clear commit messages**
4. **Test your changes** thoroughly
5. **Update documentation** if needed
6. **Make sure the code passes** `flutter analyze`

## Development Setup

1. Install Flutter SDK 3.9.2+
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/framer.git`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Code Style

- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` to check for issues
- Run `flutter format .` before committing
- Keep functions small and focused
- Write meaningful variable and function names
- Add comments for complex logic

## Clean Architecture Guidelines

This project follows Clean Architecture principles:

- **Domain Layer**: Business logic and entities (no Flutter dependencies)
- **Data Layer**: Data sources and repository implementations
- **Presentation Layer**: UI and state management

When adding features:
1. Start with the domain layer (entities, use cases)
2. Implement the data layer (repositories)
3. Finally implement the presentation layer (UI, providers)

## Commit Message Guidelines

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests after the first line

Examples:
```
Add frame rotation feature

- Add rotation slider to controls
- Implement rotation in image processing
- Update tests

Fixes #123
```

## Testing

- Write tests for new features
- Ensure all tests pass before submitting PR
- Run `flutter test` to execute tests

## Questions?

Feel free to open an issue with your question or reach out to the maintainers.

Thank you for contributing! 🎉
