import 'package:flutter/material.dart';

class LocationControlButton extends StatelessWidget {
  const LocationControlButton({
    super.key,
    required this.onPressed,
    required this.isDisabled,
  });

  final bool isDisabled;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.my_location_outlined,
        color: isDisabled ? Colors.black38 : Colors.black,
        semanticLabel: 'Pan to current location',
        size: 40,
      ),
      tooltip: 'Pan to current location',
      onPressed: isDisabled ? null : onPressed,
    );
  }
}
