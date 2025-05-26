## 2.0.0

**BREAKING CHANGES:**
- Renamed `User` model to `Profile` throughout the codebase
- Renamed `user.dart` and `user.g.dart` files to `profile.dart` and `profile.g.dart`
- Updated `UserProfileApi` class to use `Profile` instead of `User`
- All methods in `UserProfileApi` now return `Profile` objects instead of `User` objects
- Import statements must be updated from `import 'package:outseta/src/models/user.dart'` to `import 'package:outseta/src/models/profile.dart'`
- Variable declarations using `User` type must be changed to `Profile`

## 1.0.1

- Fix dangling comments
- Format code with dart formatter

## 1.0.0

- Initial release of the Outseta Dart API client
- Support for all major Outseta API endpoints:
  - CRM: People, Accounts, and Deals
  - Billing: Subscriptions, Invoices, Plans, and Payments
  - Marketing: Email campaigns, Lists, and Subscribers
  - Support: Tickets and comments
  - User Profile: User management and authentication
- Authentication methods for both server-side (API Key) and client-side (Bearer Token)
- Comprehensive model classes with full type safety
- Pagination support for list endpoints
- Error handling with typed exceptions
- Detailed documentation and examples
