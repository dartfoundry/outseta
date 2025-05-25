/// Dart API client for the Outseta.com REST API V1
///
/// This library provides a type-safe interface to the Outseta REST API,
/// allowing you to interact with CRM, Billing, Marketing, and Support functions.
library;

// Core client exports
export 'src/outseta_client.dart';
export 'src/auth/auth.dart';

// API modules
export 'src/api/crm_api.dart';
export 'src/api/billing_api.dart';
export 'src/api/marketing_api.dart';
export 'src/api/support_api.dart';
export 'src/api/user_profile_api.dart';

// Models
export 'src/models/models.dart';

// Utilities
export 'src/utils/exceptions.dart';
