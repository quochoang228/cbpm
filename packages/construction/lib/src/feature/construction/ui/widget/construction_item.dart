import 'package:cdn/cdn.dart';
import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../construction.dart';
import '../../../../entities/construction_dto.dart';

class ConstructionItem extends StatelessWidget {
  const ConstructionItem({super.key, required this.item});

  final ConstructionDto item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.push(ConstructionPaths.constructionDetail, extra: item),
      child: Container(
        padding: const EdgeInsets.all(DSSpacing.spacing4),
        color: DSColors.backgroundWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DsTitle(
            //   title: item.constructionCode ?? '',
            //   customStyle: DSTextStyle.labelMediumPromient,
            // ),
            Text(
              item.constructionCode ?? '',
              style: DSTextStyle.labelMediumPromient,
            ),
            const Gap(DSSpacing.spacing2),
            item.contractCode != null
                ? DsTitle.caption(
                    title: item.contractCode ?? '',
                    color: DSColors.textSubtitle,
                  )
                : const SizedBox(),
            const Gap(DSSpacing.spacing3),
            item.address != null
                ? Row(
                    children: [
                      CDNAssets.icons.location.svg(),
                      const Gap(DSSpacing.spacing2),
                      DsTitle.body(
                        title: item.address ?? '',
                        color: DSColors.textSubtitle,
                      ),
                    ],
                  )
                : const SizedBox(),
            const Gap(DSSpacing.spacing2),
            item.duration != null
                ? Row(
                    children: [
                      CDNAssets.icons.time.svg(),
                      const Gap(DSSpacing.spacing2),
                      DsTitle.body(
                        title: item.duration ?? '',
                        color: DSColors.textSubtitle,
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
