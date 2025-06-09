import 'package:ag/ag.dart';
import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../entities/construction_dto.dart';
import '../../provider/construction_detail_provider.dart';
import 'update_work_page.dart';

class ConstructionDetailPage extends StatefulHookConsumerWidget {
  const ConstructionDetailPage({
    super.key,
    required this.constructionDto,
  });

  final ConstructionDto constructionDto;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConstructionDetailPageState();
}

class _ConstructionDetailPageState
    extends ConsumerState<ConstructionDetailPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    Future.microtask(
      () => ref
          .read(constructionDetailProvider.notifier)
          .findByConstructionId(widget.constructionDto.constructionId!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: widget.constructionDto.constructionCode ?? 'Thông tin chi tiết',
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(DSSpacing.spacing4),
              color: DSColors.backgroundWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DsTitle(
                    title: widget.constructionDto.constructionCode ?? '',
                    customStyle: DSTextStyle.labelMediumPromient,
                  ),
                  const Gap(DSSpacing.spacing2),
                  DsTitle.caption(
                    title: 'Mã kế hoạch ${widget.constructionDto.planCode}',
                    color: DSColors.textSubtitle,
                  ),
                  DsDivider(
                    height: DSSpacing.spacing4,
                  ),
                  DsTextInfo(
                      type: DsTextInfoType.vertical,
                      title: 'Nội dung công việc:',
                      subTitle: '${widget.constructionDto.constructionCode}'),
                ],
              ),
            ),
            const Gap(DSSpacing.spacing6),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: DSSpacing.spacing4),
              child: DsTitle.body(
                title: 'Chi tiết công việc',
                color: DSColors.textSubtitle,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: MatchDataState(
                state: ref.watch(constructionDetailProvider),
                fetched: (p0) {
                  return p0.data.listWork == null || p0.data.listWork!.isEmpty
                      ? Center(child: Text('Không có công việc nào'))
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: p0.data.listWork?.length ?? 0,
                                padding: EdgeInsets.symmetric(
                                    vertical: DSSpacing.spacing3),
                                separatorBuilder: (context, index) =>
                                    const Gap(DSSpacing.spacing4),
                                itemBuilder: (context, index) {
                                  var item = p0.data.listWork![index];
                                  return Container(
                                    padding: EdgeInsets.all(DSSpacing.spacing4),
                                    color: DSColors.backgroundWhite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name ?? '',
                                          style: DSTextStyle.headlineMedium,
                                        ),
                                        const Gap(DSSpacing.spacing2),
                                        DsTitle.body(
                                          title: 'Chờ CD tiếp nhận',
                                          color: DSColors.warning,
                                          customStyle: DSTextStyle.labelMedium,
                                        ),
                                        const Gap(DSSpacing.spacing2),
                                        DsDivider(),
                                        item.showWO
                                            ? ListWorkConstruction(
                                                workDto: item,
                                              )
                                            : const SizedBox.shrink(),
                                        // ChooseItemView<ConstructionDto>(
                                        //   name: 'ProfileStateFieldNames.educationLevel.name',
                                        //   title: 'ProfileStateFieldNames.educationLevel.title',
                                        //   hintText:
                                        //       'Chọn ${'ProfileStateFieldNames.educationLevel.title'}',
                                        //   items: [],
                                        //   itemsSelected: [],
                                        //   initialValue:
                                        //       'educationLevelSelected.value.dictLabel',
                                        //   onSelected: (value) {},
                                        //   getLabel: (int index) {
                                        //     return 'test';
                                        //   },
                                        // ),
                                        // const Gap(DSSpacing.spacing6),
                                        // DSButton.ghost(
                                        //   label: 'CD tiếp nhận',
                                        //   borderSide: BorderSide(
                                        //     color: DSColors.primary,
                                        //   ),
                                        //   foregroundColor: DSColors.primary,
                                        //   onPressed: () {},
                                        // ),
                                        const Gap(DSSpacing.spacing4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DSButton.ghost(
                                                label: 'FT Từ chối',
                                                borderSide: BorderSide(
                                                  color: DSColors.primary,
                                                ),
                                                foregroundColor:
                                                    DSColors.primary,
                                                onPressed: () {},
                                              ),
                                            ),
                                            const Gap(DSSpacing.spacing4),
                                            Expanded(
                                              child: DSButton(
                                                label: 'FT Tiếp nhận',
                                                onPressed: () {},
                                              ),
                                            ),
                                            const Gap(DSSpacing.spacing4),
                                            Expanded(
                                              child: DSButton.ghost(
                                                label: 'Giao FT',
                                                borderSide: BorderSide(
                                                  color: DSColors.warning,
                                                ),
                                                foregroundColor:
                                                    DSColors.warning,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: p0.data.constructionStatus == 5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: DSSpacing.spacing4,
                                ),
                                child: DSButton(
                                  label: 'Cập nhật ngày bàn giao thực tế',
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListWorkConstruction extends StatelessWidget {
  const ListWorkConstruction({super.key, required this.workDto});

  final WorkDto workDto;

  @override
  Widget build(BuildContext context) {
    return workDto.list != null
        ? ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: workDto.list!.length,
            separatorBuilder: (context, index) => const DsDivider(),
            itemBuilder: (context, index) {
              var subItem = workDto.list![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateWorkPage(),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: DSSpacing.spacing4),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        subItem.name ?? '',
                        style: DSTextStyle.bodyMedium
                            .copyWith(color: DSColors.textSubtitle),
                      )),
                      const Gap(DSSpacing.spacing4),
                      Text(
                        subItem.status.toString(),
                        style: DSTextStyle.bodySmall
                            .copyWith(color: DSColors.textSubtitle),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: DSColors.textSubtitle,
                      ),
                      // BaseIcon(BaseIcons.chevronRight),
                    ],
                  ),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
