part of '../blocs.dart';

@lazySingleton
class AffiliateCubit extends Cubit<AffiliateState> with CubitActionMixin<AffiliateState> {
  final IAffiliateRepository _iAffiliateRepository;
  final IBillingAddressRepository _billingAddressRepository;
  final IUploadRepository _uploadRepository;
  final ISellProductRepository _sellProductRepository;
  AffiliateCubit(this._uploadRepository,this._iAffiliateRepository, this._billingAddressRepository, this._sellProductRepository) : super(AffiliateState.initial());

  List<ProductData> productSaves = [];
  List<ProductAffiliate> products = [];
  List<TransactionCommissionData> transactionCommissions = [];

  Future<void> affiliateRegister(String name, String phone, String email, String address, String identityCard, String taxCode, File frontPhoto, File backPhoto) async {
    final BaseResponseList<AppFile> responseImg = await _uploadRepository.uploadFile(
      UploadType.postImage,
      [File(frontPhoto.path), File(backPhoto.path)],
    );
    if(responseImg.status == false) {
      DMessage.showMessage(message: responseImg.message, type: MessageType.error);
      return;
    }

    executeEmptyAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateRegister({
        "name":name,
        "phone":phone,
        "email":email,
        "address":address,
        "national_id":state.selectedNation!.id,
        "city_id":state.selectedCity!.id,
        "district_id":state.selectedDistrict!.id,
        "ward_id":state.selectedWard!.id,
        "identity_card":identityCard,
        "tax_code": taxCode,
        "front_photo_identity_card":responseImg.data[0].url,
        "back_photo_identity_card":responseImg.data[1].url
      }),
      onSuccess: (response) {
        if(response.status == true) {
          DNavigator.back();
          DMessage.showMessage(message: response.message, type: MessageType.success);

        }
      },
    );
  }

  Future<void> affiliateWithdraw(int money) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateWithdraw(money),
      onSuccess: (response) {
        if(response.status == true) {
          DNavigator.pushReplacementNamed(RouteNamed.withdrawCommissionSuccess);
          DMessage.showMessage(message: response.message, type: MessageType.success);
        }
      },
    );
  }

  Future<void> affiliateUpdate(String name, String phone, String email, String address) async {
    executeEmptyAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateUpdate({
        "name":name,
        "phone":phone,
        "email":email,
        "address":address,
        "national_id":state.selectedNation!.id,
        "city_id":state.selectedCity!.id,
        "district_id":state.selectedDistrict!.id,
        "ward_id":state.selectedWard!.id
      }),
      onSuccess: (response) {
        if(response.status == true) {
           DNavigator.back();
          affiliateInfo();
          DMessage.showMessage(message: response.message, type: MessageType.success);
        }
      },
    );
  }

  Future<void> affiliateInfo() async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateInfo(),
      onSuccess: (response) {
        if(response.status == true) {
          final info = response.data!;

          emit(state.copyWith(
            affiliateInfo: info,
            nations: [info.nationalId],
            selectedNation: info.nationalId,
            cities: [info.cityId],
            selectedCity: info.cityId,
            districts: [info.districtId],
            selectedDistrict: info.districtId,
            wards: [info.wardId],
            selectedWard: info.wardId,
          ));

          // Fetch dependent data using selected values
          fetchCityList();
          fetchDistrictList();
          fetchWardList();
        }
      },
    );
  }

  Future<void> affiliateProductList({int? rating, int? categoryId, int? fromPrice, int? toPrice,int? servicePromotion, int? type, String? sort, String? keyword, String? commission,int? page}) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateProductList(rating: rating, categoryId: categoryId, fromPrice: fromPrice, toPrice: toPrice,
          servicePromotion: servicePromotion, type: type, sort: sort, keyword: keyword, commission: commission, page: page),
      onSuccess: (response) {
        if(page == 1){
          products = response.data!.data;
        } else {
          products = [...products,...response.data!.data];
        }

        emit(state.copyWith(products: products));
      },
    );
  }

  void filterProductData({
    bool isLoadMore = false,
    int fromPrice = 0,
    int toPrice = 0,
    SortOption sortOption = SortOption.related,
  }) {
    int page = isLoadMore ? state.currentPage + 1 : 1;

    final filterState = AppConfig.context!.read<ProductFilterCubit>().state;

    int fromPriceParam = fromPrice > 0 ? fromPrice : filterState.selectedPriceRange.from;
    int toPriceParam = toPrice > 0 ? toPrice : filterState.selectedPriceRange.to;

    affiliateProductList(
      categoryId: filterState.selectedCategory.id > 0
          ? filterState.selectedCategory.id : null,
      rating: filterState.selectedRating.value > 0
          ? filterState.selectedRating.value : null,
      servicePromotion: filterState.selectedServicePromotion.key > 0
          ? filterState.selectedServicePromotion.key : null,
      toPrice: toPriceParam > 0
          ? toPriceParam : null,
      fromPrice: fromPriceParam > 0
          ? fromPriceParam : null,
      type: sortOption.index,
      sort: filterState.sortType.name,
      keyword: filterState.keyword,
      page: page,
      // commission: commission
    );
  }

  void fetchFilter() async {
    executeAction(
      action: _sellProductRepository.fetchProductFilter,
      onSuccess: (response) => emit(state.copyWith(filter: response.data!)),
    );
  }

  Future<void> affiliateMoneyToCoin(int money) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateMoneyToCoin(money),
      onSuccess: (response) {
        emit(state.copyWith(coinToMoney: response.data ?? 0));
      },
    );
  }

  Future<void> affiliateHome(int page) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateHome(page),
      onSuccess: (response) {
        if(response.status == true) {
          if(page == 1) productSaves.clear();
          for (var e in response.data!.products.data) {
            productSaves.add(e);
          }

          emit(state.copyWith(
            totalCommission: response.data!.totalCommission,
            totalOrder:  response.data!.totalOrder,
            totalOrderSuccess:  response.data!.totalOrderSuccess,
            productSaves: productSaves,
          ));
        }
      },
    );
  }

  Future<void> affiliateCommission(int page) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateCommission(page),
      onSuccess: (response) {
        if(response.status == true) {
          if(page ==1) {
            transactionCommissions = response.data!.transactions.data;
          } else {
            transactionCommissions = [...transactionCommissions, ...response.data!.transactions.data];
          }

          emit(state.copyWith(totalCommission: response.data!.totalCommission, transactionCommissions: transactionCommissions));
        }
      },
    );
  }

  Future<void> affiliateAddProduct(int id) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateAddProduct(id),
      onSuccess: (response) {
        DNavigator.back();
        DMessage.showMessage(message: "Thêm sản phẩm thành công", type: MessageType.success);

        filterProductData();
      },
    );
  }

  Future<void> affiliateRequest() async {
    executeListAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _iAffiliateRepository.affiliateRequest(),
      onSuccess: (response) {
        if(response.status == true) {
          emit(state.copyWith(listAffiliateRequest: response.data));
        }
      },
    );
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

  void resetAddress() {
    emit(state.copyWith(
      selectedNation: null,
      selectedCity: null,
      selectedDistrict: null,
      selectedWard: null,
      cities: [],
      districts: [],
      wards: [],
    ));
  }

  void setAddress(AffiliateInfo info) {
    emit(state.copyWith(
      nations: [info.nationalId],
      selectedNation: info.nationalId,
      cities: [info.cityId],
      selectedCity: info.cityId,
      districts: [info.districtId],
      selectedDistrict: info.districtId,
      wards: [info.wardId],
      selectedWard: info.wardId,
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
}