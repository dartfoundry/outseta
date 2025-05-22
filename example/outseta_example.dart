import 'package:outseta/outseta.dart';

void main() async {
  // Initialize the Outseta client with your domain and API key auth
  final client = OutsetaClient(
    baseUrl: 'https://your-domain.outseta.com/api/v1',
    auth: ApiKeyAuth(
      apiKey: 'your-api-key',
      secretKey: 'your-secret-key',
    ),
  );

  try {
    // ===== CRM API EXAMPLES =====
    print('===== CRM API EXAMPLES =====');
    
    // Example: Get a list of people from the CRM
    final peopleResponse = await client.crm.getPeople(limit: 10);
    print('Found ${peopleResponse.metadata.total} people in total');
    print('First page has ${peopleResponse.items.length} people');
    
    for (final person in peopleResponse.items) {
      print('- ${person.fullName} (${person.email})');
    }

    // Example: Get a specific account
    if (peopleResponse.items.isNotEmpty && peopleResponse.items.first.accountUid != null) {
      final accountUid = peopleResponse.items.first.accountUid!;
      final account = await client.crm.getAccount(accountUid);
      print('\nAccount: ${account.name}');
      print('Billing Address: ${account.billingAddress?.city}, ${account.billingAddress?.state}');
    }

    // Example: Create a new person
    print('\nCreating a new person...');
    final newPerson = Person(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
    );
    
    try {
      final createdPerson = await client.crm.createPerson(newPerson);
      print('Created person: ${createdPerson.fullName} (${createdPerson.uid})');
    } catch (e) {
      print('Error creating person: $e');
      // Continue with the rest of the examples
    }

    // ===== BILLING API EXAMPLES =====
    print('\n===== BILLING API EXAMPLES =====');
    
    // Example: Get active subscription plans
    final plansResponse = await client.billing.getPlans(
      filter: 'IsActive eq true',
    );
    print('\nActive subscription plans:');
    for (final plan in plansResponse.items) {
      print('- ${plan.name}: \$${plan.amount} per ${plan.billingTerm?.toLowerCase()}');
    }
    
    // Example: Get invoices
    print('\nGetting recent invoices...');
    final invoicesResponse = await client.billing.getInvoices(limit: 5);
    print('Found ${invoicesResponse.metadata.total} invoices in total');
    for (final invoice in invoicesResponse.items) {
      print('- Invoice #${invoice.invoiceNumber}: \$${invoice.total} (${invoice.status})');
    }

    // ===== MARKETING API EXAMPLES =====
    print('\n===== MARKETING API EXAMPLES =====');
    
    // Example: Get email lists
    print('\nGetting email lists...');
    final listsResponse = await client.marketing.getLists();
    print('Found ${listsResponse.metadata.total} email lists:');
    for (final list in listsResponse.items) {
      print('- ${list.name}: ${list.subscriberCount} subscribers');
    }
    
    // Example: Get email campaigns
    print('\nGetting email campaigns...');
    final emailsResponse = await client.marketing.getEmails(limit: 5);
    print('Found ${emailsResponse.metadata.total} email campaigns:');
    for (final email in emailsResponse.items) {
      final status = email.status ?? 'Unknown';
      print('- ${email.subject} (Status: $status)');
    }

    // ===== SUPPORT API EXAMPLES =====
    print('\n===== SUPPORT API EXAMPLES =====');
    
    // Example: Get support tickets
    print('\nGetting support tickets...');
    final ticketsResponse = await client.support.getTickets(limit: 5);
    print('Found ${ticketsResponse.metadata.total} tickets:');
    for (final ticket in ticketsResponse.items) {
      print('- ${ticket.subject} (${ticket.status})');
    }
    
    // Example for creating a new ticket
    print('\nCreating a sample support ticket...');
    final newTicket = Ticket(
      subject: 'API Test Ticket',
      description: 'This is a test ticket created via the API',
      priority: 'Medium',
    );
    
    try {
      final createdTicket = await client.support.createTicket(newTicket);
      print('Created ticket: ${createdTicket.subject} (${createdTicket.uid})');
      
      // Add a comment to the ticket
      final updatedTicket = await client.support.addComment(
        createdTicket.uid!,
        'This is a test comment added via the API',
        isPrivate: true,
      );
      print('Added comment to ticket. Current status: ${updatedTicket.status}');
    } catch (e) {
      print('Error with support ticket operations: $e');
      // Continue with the rest of the examples
    }

    // ===== USER PROFILE API EXAMPLES =====
    print('\n===== USER PROFILE API EXAMPLES =====');
    
    // Example: Get current user (requires authentication)
    try {
      print('\nAttempting to get current user profile...');
      final currentUser = await client.userProfile.getCurrentUser();
      print('Current user: ${currentUser.email} (${currentUser.firstName} ${currentUser.lastName})');
    } catch (e) {
      print('Error getting current user: $e');
      print('Note: This endpoint requires proper authentication with a user token');
    }
    
    // Example: Demonstrate requesting password reset
    print('\nDemonstrating password reset request (not actually sending)...');
    print('To request password reset: await client.userProfile.requestPasswordReset("user@example.com")');

  } catch (e) {
    print('Error: $e');
  } finally {
    // Close the client when done
    client.close();
  }
}
