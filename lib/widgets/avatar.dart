import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.photoURL,
    required this.radius,
    this.onPress,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);
  final String? photoURL;
  final double radius;
  final VoidCallback? onPress;
  final Color? borderColor;
  final double? borderWidth;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor!, width: borderWidth!),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: photoURL != null ? NetworkImage(photoURL!) : null,
          backgroundColor: Colors.black12,
          child: photoURL == null ? const Icon(Icons.add) : null,
        ),
      ),
    );
  }
}
