class Validators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final digitRegex = RegExp(r'\d');
    final symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!upperCaseRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!lowerCaseRegex.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!digitRegex.hasMatch(value)) {
      return 'Password must contain at least one numeric digit';
    }
    if (!symbolRegex.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}