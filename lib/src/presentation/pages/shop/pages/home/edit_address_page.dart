part of '../../shop.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specificAddressController = TextEditingController();
  ValueNotifier<bool> isDefault = ValueNotifier(false);

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() { 
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserBillingAddress userBillingAddress = context.read<DeliveryAddressCubit>().state.currentAddress;
      nameController.text = userBillingAddress.name;
      phoneController.text = userBillingAddress.phone;
      specificAddressController.text = userBillingAddress.detail;
      isDefault.value = userBillingAddress.isDefault;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UpdateAddressBody(
      title: context.text.editAddress,
      nameController: nameController,
      phoneController: phoneController,
      specificAddressController: specificAddressController,
      isDefault: isDefault,
      onSave: () {
        context.read<DeliveryAddressCubit>().updateBillingAddress(
              name: nameController.text,
              phone: phoneController.text,
              detailAddress: specificAddressController.text,
              isDefault: isDefault.value,
            );
      },
    );
  }
}
