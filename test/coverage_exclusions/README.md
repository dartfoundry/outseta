# Test Coverage Exclusions

This document explains parts of the codebase that have been intentionally excluded from test coverage requirements or where achieving high coverage is challenging.

## Auth Module

### `getAuthToken()` Function

The `getAuthToken()` function in `lib/src/auth/auth.dart` is not directly tested because:

1. It requires actual network connections to Outseta's authentication API
2. The function creates and manages its own HTTP client instance, making it difficult to mock without significantly changing the implementation
3. The function primarily relies on the HTTP client functionality which is already well-tested by the underlying library

In a real-world scenario, this function would be better suited for integration tests rather than unit tests.

### Alternative Testing Approaches

For components that depend on `getAuthToken()`, consider:

- Creating test-specific wrappers or utilities that allow dependency injection
- Using integration tests for end-to-end authentication flows
- Testing the consuming code with mocked authentication tokens

## Other Excluded Areas

Add other excluded components here as they are identified, along with justification for exclusion.