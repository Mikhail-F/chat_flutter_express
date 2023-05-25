import 'package:auth_flutter_express/models/user_profile_model.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final UserProfileModel item;
  final Function(int) onPress;
  const UserItem({super.key, required this.item, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() => onPress(item.id),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(item.name),
      ),
    );
  }
}
