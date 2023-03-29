import 'package:flutter/widgets.dart';

abstract class NotifierXListener extends ChangeNotifier {
  void onInit();
  void onClose();
  void onDependencies();
}