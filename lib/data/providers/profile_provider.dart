import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, Profile>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<Profile> {
  ProfileNotifier()
      : super(Profile(
          name: 'Hikmatullo',
          email: 'Sog\'lomturmush@gmail.com',
          phoneNumber: '+99890 378 6263',
        ));

  void updateName(String newName) {
    state = Profile(
      name: newName,
      email: state.email,
      phoneNumber: state.phoneNumber,
    );
  }

  void updateEmail(String newEmail) {
    state = Profile(
      name: state.name,
      email: newEmail,
      phoneNumber: state.phoneNumber,
    );
  }

  void updatePhoneNumber(String newPhoneNumber) {
    state = Profile(
      name: state.name,
      email: state.email,
      phoneNumber: newPhoneNumber,
    );
  }

  void deleteProfile() {
    // Implement profile deletion logic
  }
}
