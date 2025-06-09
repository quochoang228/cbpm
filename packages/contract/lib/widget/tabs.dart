import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class CustomizeTabs extends StatefulWidget {

  final Color backgroundColor;

  final List<Widget> tabHeader;

  final List<Widget> tabContents;

  final int initialTab;

  final Function(int index)? onChangeTab;

  const CustomizeTabs({
    Key? key,
    this.backgroundColor = Colors.white,
    required this.tabHeader,
    required this.tabContents,
    this.initialTab = 0,
    this.onChangeTab,
  }) : super(key: key);

  @override
  _CustomizeTabs createState() {
    return _CustomizeTabs();
  }
}

class _CustomizeTabs extends State<CustomizeTabs> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabContents.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabHeader.length,
      initialIndex: widget.initialTab,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 10,
          bottom: TabBar(
            isScrollable: widget.tabHeader.length > 3 ? true : false,
            labelColor: DSColors.primary,
            unselectedLabelColor: DSColors.primary,
            indicatorColor: DSColors.primary,
            labelStyle: DSTextStyle.headlineMedium,
            unselectedLabelStyle: DSTextStyle.headlineMedium.copyWith(
              fontWeight: FontWeight.w400,
            ),
            controller: _tabController,
            onTap: (index) {
              widget.onChangeTab?.call(index);
            },
            tabs: widget.tabHeader.map((tab) {
              return Tab(child: tab);
            }).toList(),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: widget.tabContents,
        ),
      ),
    );
  }
}
