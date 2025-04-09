enum ChatType {
  group,
  individual;

  String get displayName => switch (this) {
        group => 'GROUP',
        individual => 'ONE_TO_ONE',
      };

  static ChatType parse(String? value) {
    switch (value) {
      case "GROUP":
        return ChatType.group;
      case "ONE_TO_ONE":
        return ChatType.individual;
      default:
        return ChatType.individual;
    }
  }
}

enum MessageType {
  text,
  quotation,
  quotationReply,
  request;

  String get backendEnum => switch (this) {
        text => 'TEXT',
        quotation => 'QUOTATION',
        quotationReply => 'REPLIED',
        request => 'request'
      };

  static MessageType getMessageType(String? value) {
    switch (value) {
      case "TEXT":
        return MessageType.text;
      case "QUOTATION":
        return MessageType.quotation;
      case "REPLIED":
        return MessageType.quotationReply;
      default:
        return MessageType.text;
    }
  }
}

enum QuotationActionTypes {
  accept,
  bidAgain,
  reject;

  String get displayName => switch (this) {
        accept => 'Accept',
        bidAgain => 'Bid Again',
        reject => 'Reject'
      };
}

enum MessageStatusEnum {
  failed,
  delay,
  sent,
  none;

  String get backendEnum => switch (this) {
        failed => 'failed',
        delay => 'delay',
        sent => 'sent',
        none => 'none'
      };
}

enum MessageReaadStatusEnum {
  sent,
  seen,
  none;
}

enum MessageStatus {
  accepted,
  rejected,
  bidAgain,
  active,
  completed,
  canceled,
  ;

  String get backendEnum => switch (this) {
        accepted => 'ACCEPTED',
        rejected => 'REJECTED',
        bidAgain => 'BIDAGAIN',
        active => 'ACTIVE',
        completed => 'COMPLETED',
        canceled => 'CANCELED'
      };

  String get message => switch (this) {
        accepted => 'Approved',
        rejected => 'Rejected',
        bidAgain => 'Bid again requested',
        active => 'Acctive',
        completed => 'Completed',
        canceled => 'Canceled'
      };

  static MessageStatus getStatusType(String? value) {
    switch (value) {
      case "ACCEPTED":
        return MessageStatus.accepted;
      case "REJECTED":
        return MessageStatus.rejected;
      case "BIDAGAIN":
        return MessageStatus.bidAgain;
      case "ACTIVE":
        return MessageStatus.active;
      case "COMPLETED":
        return MessageStatus.completed;
      case "CANCELED":
        return MessageStatus.canceled;
      default:
        return MessageStatus.active;
    }
  }
}

enum ChatMode {
  job,
  request,
  report;

  String get backendEnum =>
      switch (this) { job => 'JOB', request => 'REQUEST', report => 'REPORT' };

  static ChatMode getMessageType(String? value) {
    switch (value) {
      case "JOB":
        return ChatMode.job;
      case "REQUEST":
        return ChatMode.request;
      case "REPORT":
        return ChatMode.report;
      default:
        return ChatMode.job;
    }
  }

  static String displayName(String? value) {
    switch (value) {
      case "JOB":
        return "Job";
      case "REQUEST":
        return "Request";
      case "REPORT":
        return "Report";
      default:
        return '';
    }
  }
}
