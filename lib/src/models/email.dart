import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'list.dart';

part 'email.g.dart';

/// Email model representing an email campaign in the Outseta Marketing API
@JsonSerializable()
class Email extends BaseModelWithMetadata {
  /// Creates a new Email instance
  const Email({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.subject,
    this.fromName,
    this.fromEmail,
    this.replyToEmail,
    this.content,
    this.status,
    this.scheduledDate,
    this.sentDate,
    this.openCount,
    this.clickCount,
    this.emailListUid,
    this.emailList,
    this.personSegmentUid,
    this.customFields,
  });

  /// Factory constructor that creates an [Email] from JSON data
  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  /// The subject of the email
  @JsonKey(name: 'Subject')
  final String? subject;

  /// The sender's name
  @JsonKey(name: 'FromName')
  final String? fromName;

  /// The sender's email address
  @JsonKey(name: 'FromEmail')
  final String? fromEmail;

  /// The reply-to email address
  @JsonKey(name: 'ReplyToEmail')
  final String? replyToEmail;

  /// The content of the email
  @JsonKey(name: 'Content')
  final String? content;

  /// The status of the email (e.g., 'Draft', 'Scheduled', 'Sent')
  @JsonKey(name: 'Status')
  final String? status;

  /// The scheduled date for sending the email
  @JsonKey(name: 'ScheduledDate')
  final DateTime? scheduledDate;

  /// The date the email was sent
  @JsonKey(name: 'SentDate')
  final DateTime? sentDate;

  /// The number of times the email was opened
  @JsonKey(name: 'OpenCount')
  final int? openCount;

  /// The number of times links in the email were clicked
  @JsonKey(name: 'ClickCount')
  final int? clickCount;

  /// The UID of the email list this campaign targets
  @JsonKey(name: 'EmailListUid')
  final String? emailListUid;

  /// The email list this campaign targets
  @JsonKey(name: 'EmailList')
  final EmailList? emailList;

  /// The UID of the person segment this campaign targets
  @JsonKey(name: 'PersonSegmentUid')
  final String? personSegmentUid;

  /// Custom fields associated with this email
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this email instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$EmailToJson(this);

  /// Creates a copy of this email with the given fields replaced with new values
  Email copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? subject,
    String? fromName,
    String? fromEmail,
    String? replyToEmail,
    String? content,
    String? status,
    DateTime? scheduledDate,
    DateTime? sentDate,
    int? openCount,
    int? clickCount,
    String? emailListUid,
    EmailList? emailList,
    String? personSegmentUid,
    Map<String, dynamic>? customFields,
  }) {
    return Email(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      subject: subject ?? this.subject,
      fromName: fromName ?? this.fromName,
      fromEmail: fromEmail ?? this.fromEmail,
      replyToEmail: replyToEmail ?? this.replyToEmail,
      content: content ?? this.content,
      status: status ?? this.status,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      sentDate: sentDate ?? this.sentDate,
      openCount: openCount ?? this.openCount,
      clickCount: clickCount ?? this.clickCount,
      emailListUid: emailListUid ?? this.emailListUid,
      emailList: emailList ?? this.emailList,
      personSegmentUid: personSegmentUid ?? this.personSegmentUid,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        subject,
        fromName,
        fromEmail,
        replyToEmail,
        content,
        status,
        scheduledDate,
        sentDate,
        openCount,
        clickCount,
        emailListUid,
        emailList,
        personSegmentUid,
        customFields,
      ];
}