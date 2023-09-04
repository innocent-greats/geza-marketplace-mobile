import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, String>? _localizedStrings;

extension StringUtil on String {
  Color get toColor {
    String data = replaceAll("#", "");
    if (data.length == 6) {
      data = "FF$data";
    }
    return Color(int.parse("0x$data"));
  }

  String maxLength(int length) {
    if (length > length) {
      return this;
    } else {
      return substring(0, length);
    }
  }

  String toParagraph([bool addDash = false]) {
    return addDash ? "-\t${this}" : "\t${this}";
  }

  bool toBool([bool defaultValue = false]) {
    if (toString().compareTo('1') == 0 || toString().compareTo('true') == 0) {
      return true;
    } else if (toString().compareTo('0') == 0 ||
        toString().compareTo('false') == 0) {
      return false;
    }
    return defaultValue;
  }

  int? toInt([int? defaultValue]) {
    try {
      return int.parse(this);
    } catch (e) {
      return defaultValue;
    }
  }

  double toDouble([double defaultValue = 0]) {
    try {
      return double.parse(this);
    } catch (e) {
      return defaultValue;
    }
  }

  String get capitalizeWords {
    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }

  String? get nullIfEmpty {
    return isEmpty ? null : this;
  }
}

extension NullableStringUtil on String? {
  String get toStringOrEmpty {
    if (this != null) {
      return toString();
    } else {
      return '';
    }
  }
}

//------ App Localization Extension --------------------------//

extension StringLocalization on String {

String trimp(String text) {
  if (_localizedStrings != null) {
    String? value = _localizedStrings![text];
    return value ?? autoTranslate(text);
  }

  return autoTranslate(text);
}

String autoTranslate(String text) {
  // log("You need to translate this text : " + text);
  at(text);

  try {
    List<String> texts = text.split("_");
    StringBuffer stringBuffer = StringBuffer();
    for (String singleText in texts) {
      stringBuffer
          .write("${singleText[0].toUpperCase()}${singleText.substring(1)} ");
    }
    String result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  } catch (err) {
    return text;
  }
}

Future<void> at(String t) async {
  // print("at");
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var data = sharedPreferences.getStringList('test_tr') ?? [];
  var set = data.toSet();
  set.add(t);
  sharedPreferences.setStringList('test_tr', set.toList());
}
}
