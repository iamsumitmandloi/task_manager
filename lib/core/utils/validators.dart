bool isValidTitle(String title) => title.trim().length >= 3;
bool isValidEmail(String email) => email.contains('@') && email.contains('.');
