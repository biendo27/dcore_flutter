part of '../../shop.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specificAddressController = TextEditingController();
  ValueNotifier<bool> isDefault = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return UpdateAddressBody(
      title: context.text.newAddress,
      nameController: nameController,
      phoneController: phoneController,
      specificAddressController: specificAddressController,
      isDefault: isDefault,
      onSave: () {
        context.read<DeliveryAddressCubit>().createBillingAddress(
              name: nameController.text,
              phone: phoneController.text,
              detailAddress: specificAddressController.text,
              isDefault: isDefault.value,
            );
      },
    );
  }
}
