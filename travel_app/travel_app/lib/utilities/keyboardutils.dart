import 'package:flutter/cupertino.dart';

class KeyboardUtils {
  static bool isKeyboardShowing() {
    try {
      return WidgetsBinding.instance.window.viewInsets.bottom > 0;
    } catch(e) {
      print(e);
      return false;
    }
  }
  
  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }
  }
}