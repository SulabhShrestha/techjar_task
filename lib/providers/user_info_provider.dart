import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoProvider = Provider<Map<String, dynamic>>((ref) {
  return Map<String, dynamic>.from({
    'name': 'Tech Jar Pvt Ltd',
    'email': 'tech@techjar.com.np',
    'uid': "1377x.",
  });
});
