part of '../shop.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });
  final String title;
  final String description;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
