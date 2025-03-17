part of '../blocs.dart';

@lazySingleton
class DeliveryAddressCubit extends Cubit<DeliveryAddressState> with CubitActionMixin<DeliveryAddressState> {
  final IBillingAddressRepository _billingAddressRepository;

  DeliveryAddressCubit(this._billingAddressRepository) : super(DeliveryAddressState.initial());

  void reset() {
    emit(DeliveryAddressState.initial());
  }

  void setCurrentAddress(UserBillingAddress address) {
    emit(state.copyWith(currentAddress: address));
  }

  void setAddressFromBilling(UserBillingAddress address) {
    emit(state.copyWith(
      currentAddress: address,
      nations: [address.national],
      selectedNation: address.national,
      cities: [address.city],
      selectedCity: address.city,
      districts: [address.district],
      selectedDistrict: address.district,
      wards: [address.ward],
      selectedWard: address.ward,
    ));

    // Fetch dependent data using selected values
    fetchCityList();
    fetchDistrictList();
    fetchWardList();
  }

  void setSelectedNation(Nation? nation) {
    if (nation == state.selectedNation) return;
    emit(state.copyWith(
      selectedNation: nation,
      selectedCity: null,
      selectedDistrict: null,
      selectedWard: null,
      cities: [],
      districts: [],
      wards: [],
    ));
    if (nation != null) {
      fetchCityList(nation.id);
    }
  }

  void setSelectedCity(City? city) {
    if (city == state.selectedCity) return;
    emit(state.copyWith(
      selectedCity: city,
      selectedDistrict: null,
      selectedWard: null,
      districts: [],
      wards: [],
    ));
    if (city != null) {
      fetchDistrictList(city.id);
    }
  }

  void setSelectedDistrict(District? district) {
    if (district == state.selectedDistrict) return;
    emit(state.copyWith(
      selectedDistrict: district,
      selectedWard: null,
      wards: [],
    ));
    if (district != null) {
      fetchWardList(district.id);
    }
  }

  void setSelectedWard(Ward? ward) {
    if (ward == state.selectedWard) return;
    emit(state.copyWith(selectedWard: ward));
  }

  Future<void> fetchNationList() async {
    executeListAction(
      action: () => _billingAddressRepository.fetchNationList(),
      onSuccess: (response) {
        emit(state.copyWith(nations: response.data));
      },
    );
  }

  Future<void> fetchCityList([int? nationId]) async {
    final selectedId = nationId ?? state.selectedNation?.id;
    if (selectedId == null) return;

    executeListAction(
      action: () => _billingAddressRepository.fetchCityList(selectedId),
      onSuccess: (response) {
        emit(state.copyWith(cities: response.data));
      },
    );
  }

  Future<void> fetchDistrictList([int? cityId]) async {
    final selectedId = cityId ?? state.selectedCity?.id;
    if (selectedId == null) return;

    executeListAction(
      action: () => _billingAddressRepository.fetchDistrictList(selectedId),
      onSuccess: (response) {
        emit(state.copyWith(districts: response.data));
      },
    );
  }

  Future<void> fetchWardList([int? districtId]) async {
    final selectedId = districtId ?? state.selectedDistrict?.id;
    if (selectedId == null) return;

    executeListAction(
      action: () => _billingAddressRepository.fetchWardList(selectedId),
      onSuccess: (response) {
        emit(state.copyWith(wards: response.data));
      },
    );
  }

  Future<void> fetchBillingAddresses() async {
    executeListAction(
      action: () => _billingAddressRepository.fetchBillingAddress(),
      onSuccess: (response) {
        emit(state.copyWith(addresses: response.data));
      },
    );
  }

  Future<void> createBillingAddress({
    required String name,
    required String phone,
    required String detailAddress,
    required bool isDefault,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'national_id': state.selectedNation?.id,
      'city_id': state.selectedCity?.id,
      'district_id': state.selectedDistrict?.id,
      'ward_id': state.selectedWard?.id,
      'detail': detailAddress,
      'is_default': isDefault,
    };
    LogDev.one(data.toString());
    executeEmptyAction(
      action: () => _billingAddressRepository.createBillingAddress(data),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        fetchBillingAddresses();
        DNavigator.back();
      },
    );
  }

  Future<void> updateBillingAddress({
    required String name,
    required String phone,
    required String detailAddress,
    required bool isDefault,
  }) async {
    Map<String, dynamic> data = {
      'id': state.currentAddress.id,
      'billing_address_id': state.currentAddress.id,
      'name': name,
      'phone': phone,
      'national_id': state.selectedNation?.id,
      'city_id': state.selectedCity?.id,
      'district_id': state.selectedDistrict?.id,
      'ward_id': state.selectedWard?.id,
      'detail': detailAddress,
      'is_default': isDefault,
    };
    executeEmptyAction(
      action: () => _billingAddressRepository.updateBillingAddress(data),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        fetchBillingAddresses();
        DNavigator.back();
      },
    );
  }

  // Helper method to get address data for API calls
  Map<String, dynamic> getAddressData({required String address}) {
    if (!state.isValidLocation) return {};

    return {
      'address': address,
      'nation_id': state.selectedNation?.id,
      'city_id': state.selectedCity?.id,
      'district_id': state.selectedDistrict?.id,
      'ward_id': state.selectedWard?.id,
    };
  }
}
