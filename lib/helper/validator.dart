class CustomValidator {
  String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
    if (value != null) {
      if (value.length != 10) {
        return 'Mobile Number must be of 10 digit';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
