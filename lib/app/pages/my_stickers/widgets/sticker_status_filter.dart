import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/ui/styles/button_styles.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/ui/styles/text_styles.dart';
import 'package:fwc_album_app/app/core/ui/widgets/button.dart';

class StickerStatusFilter extends StatelessWidget {
  final String filterSelected;

  const StickerStatusFilter({super.key, required this.filterSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: [
          Button(
            width: MediaQuery.of(context).size.width * .3,
            onPressed: () {},
            style: context.buttonStyles.yellowButton,
            labelStyle: context.textStyles.textSecondaryFontMedium
                .copyWith(color: context.colors.primary),
            label: 'Todas',
          ),
          Button(
            width: MediaQuery.of(context).size.width * .3,
            onPressed: () {},
            style: context.buttonStyles.primaryButton,
            labelStyle: context.textStyles.textSecondaryFontMedium,
            label: 'Faltando',
          ),
          Button(
            width: MediaQuery.of(context).size.width * .3,
            onPressed: () {},
            style: context.buttonStyles.primaryButton,
            labelStyle: context.textStyles.textSecondaryFontMedium,
            label: 'Repetidas',
          ),
        ],
      ),
    );
  }
}
