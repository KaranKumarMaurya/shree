import 'package:get_it/get_it.dart';

import 'call-email-widget.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}