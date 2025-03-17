part of '../setting.dart';

class SummissionProductFilterHeader extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String newValue) onSearch;
  const SummissionProductFilterHeader({super.key, required this.searchController, required this.onSearch,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: DNavigator.back,
          child: Icon(FontAwesomeIcons.arrowLeft, size: 24.sp),
        ),
        10.horizontalSpace,
        SearchTextfield(
          expandFlex: 1,
          controller: searchController,
          onChanged: onSearch,
        ),
        10.horizontalSpace,
        InkWell(
          onTap: () => Scaffold.of(context).openEndDrawer(),
          child: Icon(Icons.filter_alt_outlined, size: 25.sp),
        ),
      ],
    );
  }
}
