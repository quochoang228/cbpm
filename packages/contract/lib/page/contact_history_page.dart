part of '../../contract.dart';

class ContactHistoryPage extends StatefulHookConsumerWidget {
  const ContactHistoryPage({super.key});

  @override
  ConsumerState<ContactHistoryPage> createState() => _ContactHistoryPageState();
}

class _ContactHistoryPageState extends ConsumerState<ContactHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final pdfGlobalKey = useMemoized(GlobalKey<SfPdfViewerState>.new, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lịch sử tác động hợp đồng',
          style: DSTextStyle.headlineLarge.semiBold(),
        ),
        backgroundColor: DSColors.backgroundWhite,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                return Container();
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
