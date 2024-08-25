import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genderProvider = StateProvider<String>((ref) => 'Erkak');
final ageProvider = StateProvider<String?>((ref) => null);
final heightProvider = StateProvider<String?>((ref) => null);
final weightProvider = StateProvider<String?>((ref) => null);
