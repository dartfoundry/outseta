import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'person.dart';

part 'ticket.g.dart';

/// Ticket model representing a support ticket in the Outseta API
@JsonSerializable()
class Ticket extends BaseModelWithMetadata {
  /// Creates a new Ticket instance
  const Ticket({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.subject,
    this.description,
    this.status,
    this.priority,
    this.requesterPersonUid,
    this.requesterPerson,
    this.assignedToPersonUid,
    this.assignedToPerson,
    this.comments,
    this.accountUid,
    this.source,
    this.customFields,
  });

  /// Factory constructor that creates a [Ticket] from JSON data
  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  /// The subject of the ticket
  @JsonKey(name: 'Subject')
  final String? subject;

  /// The description of the ticket
  @JsonKey(name: 'Description')
  final String? description;

  /// The status of the ticket (e.g., 'Open', 'In Progress', 'Resolved', 'Closed')
  @JsonKey(name: 'Status')
  final String? status;

  /// The priority of the ticket (e.g., 'Low', 'Medium', 'High', 'Urgent')
  @JsonKey(name: 'Priority')
  final String? priority;

  /// The UID of the person who requested the ticket
  @JsonKey(name: 'RequesterPersonUid')
  final String? requesterPersonUid;

  /// The person who requested the ticket
  @JsonKey(name: 'RequesterPerson')
  final Person? requesterPerson;

  /// The UID of the person the ticket is assigned to
  @JsonKey(name: 'AssignedToPersonUid')
  final String? assignedToPersonUid;

  /// The person the ticket is assigned to
  @JsonKey(name: 'AssignedToPerson')
  final Person? assignedToPerson;

  /// The comments on the ticket
  @JsonKey(name: 'Comments')
  final List<dynamic>? comments;

  /// The UID of the account associated with this ticket
  @JsonKey(name: 'AccountUid')
  final String? accountUid;

  /// The source of the ticket (e.g., 'Email', 'Web', 'API')
  @JsonKey(name: 'Source')
  final String? source;

  /// Custom fields associated with this ticket
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this ticket instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$TicketToJson(this);

  /// Creates a copy of this ticket with the given fields replaced with new values
  Ticket copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? subject,
    String? description,
    String? status,
    String? priority,
    String? requesterPersonUid,
    Person? requesterPerson,
    String? assignedToPersonUid,
    Person? assignedToPerson,
    List<dynamic>? comments,
    String? accountUid,
    String? source,
    Map<String, dynamic>? customFields,
  }) {
    return Ticket(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      requesterPersonUid: requesterPersonUid ?? this.requesterPersonUid,
      requesterPerson: requesterPerson ?? this.requesterPerson,
      assignedToPersonUid: assignedToPersonUid ?? this.assignedToPersonUid,
      assignedToPerson: assignedToPerson ?? this.assignedToPerson,
      comments: comments ?? this.comments,
      accountUid: accountUid ?? this.accountUid,
      source: source ?? this.source,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    subject,
    description,
    status,
    priority,
    requesterPersonUid,
    requesterPerson,
    assignedToPersonUid,
    assignedToPerson,
    comments,
    accountUid,
    source,
    customFields,
  ];
}
