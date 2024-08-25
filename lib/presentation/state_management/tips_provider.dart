import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tipsPageControllerProvider = Provider<PageController>((ref) {
  return PageController();
});
