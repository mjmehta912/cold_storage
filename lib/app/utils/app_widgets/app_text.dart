import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    required this.text,
    super.key,
    this.style,
    this.align,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // style: style ?? Theme.of(context).textTheme.labelMedium,
      style: style ?? TextStyles.kPrimaryRegularInter(),
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
