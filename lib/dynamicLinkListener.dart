import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

import 'acceptPatient.dart';

// Handle incoming dynamic links
void initDynamicLinks() async {
  // Listen for incoming dynamic links
  try {
    final initialLink = await getInitialLink();
    if (initialLink != null){
      _handleDynamicLink(initialLink);
    }
  } on PlatformException {
    // Handle exception by warning the user or logging an error
  }
  linkStream.listen((link) {
  if (link != null){
    _handleDynamicLink(link);
  }
  }, onError: (err) {
    // Handle exception by warning the user or logging an error
  });
}

// Handle the dynamic link by calling the acceptPatient function
void _handleDynamicLink(String link) {
  if (link == null) {
    // Handle null link by warning the user or logging an error
    return;
  }
  // Extract the email address from the link
  String patientEmail = Uri.parse(link).pathSegments.last;
  // Call the acceptPatient function with the email address
  acceptPatient(patientEmail);
}
