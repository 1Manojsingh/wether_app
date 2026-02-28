import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int? status;
  final int? errorCode;
  final String? message;

  const Failure(this.status, this.errorCode, this.message);

  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      json['status'] as int?,
      json['errorCode'] as int?,
      json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'errorCode': errorCode,
      'message': message,
    };
  }

  Failure copyWith({
    int? status,
    int? errorCode,
    String? message,
  }) {
    return Failure(
      status ?? this.status,
      errorCode ?? this.errorCode,
      message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, errorCode, message];

  @override
  String toString() {
    return 'Failure(status: $status, errorCode: $errorCode, message: $message)';
  }
}
