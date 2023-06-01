import 'package:auth_flutter_express/utils/custom_colors.dart';
import 'package:flutter/material.dart';

ElevatedButton CustomButton({
  required BuildContext context,
  required Function onPress,
  required String title,
  bool disabled = false,
  Color? textColor,
  Color? backgroundColor,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      disabledBackgroundColor: CustomColors.grey,
      backgroundColor: disabled ? CustomColors.grey : Colors.blue,
      elevation: 0,
      minimumSize: Size(MediaQuery.of(context).size.width, 40),
      shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: disabled ? CustomColors.grey : Colors.blue, width: 2)),
    ),
    onPressed: !disabled ? () => onPress() : null,
    child: Text(title,
        style: TextStyle(color: textColor ?? CustomColors.white, fontSize: 16)),
  );
}
