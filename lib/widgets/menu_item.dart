import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Widget image;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFFDECEC), // Light pink background
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   padding: EdgeInsets.all(DSSpacing.spacing25),
          //   child: image,
          // ),
          image,
          const Gap(DSSpacing.spacing1),
          Text(
            title,
            textAlign: TextAlign.center,
            style: DSTextStyle.labelSmall.medium().copyWith(
                  color: DSColors.textLabel,
                ),
          ),
        ],
      ),
    );
  }
}
