sealed class Failure {
  final String message;
  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class BackupFailure extends Failure {
  const BackupFailure(super.message);
}

class NotificationFailure extends Failure {
  const NotificationFailure(super.message);
}
