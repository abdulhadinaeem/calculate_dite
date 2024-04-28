mixin Validator {
  RegExp nameRegExp =
      RegExp(r'^(?=[a-zA-Z0-9._]{3,20}$)(?!.*[_.]{2})[^_.].*[^_.]$');
  RegExp numberRegExp = RegExp(r'^[0-9]');
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp mealRegExp = RegExp(r'^[a-zA-Z0-9_]*$');
  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    if (!nameRegExp.hasMatch(value)) {
      return "Please enter valid name";
    } else {
      return null;
    }
  }

  String? ageValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter your age";
    }
    if (!numberRegExp.hasMatch(value)) {
      return "Please enter valid age";
    } else {
      return null;
    }
  }

  String? caloriesValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter meal calories";
    }
    if (!numberRegExp.hasMatch(value)) {
      return "Please enter valid calories";
    } else {
      return null;
    }
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter email";
    }
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter valid email";
    } else {
      return null;
    }
  }

  String? mealValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter meal";
    }
    if (!mealRegExp.hasMatch(value)) {
      return "Please enter valid meal";
    } else {
      return null;
    }
  }
}
