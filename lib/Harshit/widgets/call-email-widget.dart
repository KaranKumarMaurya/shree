import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
  void call(String phoneNumber) => launch("tel:$phoneNumber");
  void sendEmail(String email) => launch("mailto:$email");
}