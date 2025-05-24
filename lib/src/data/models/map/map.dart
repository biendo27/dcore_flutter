part of '../models.dart';

class MapAutoCompleteResult {
  String description;
  List<MatchedSubstrings> matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting structuredFormatting;
  List<Terms> terms;
  List<String> types;
  MapAutoCompleteResult({
    this.description = '',
    this.matchedSubstrings = const [],
    this.placeId = '',
    this.reference = '',
    StructuredFormatting? structuredFormatting,
    this.terms = const [],
    this.types = const [],
  }) : structuredFormatting = structuredFormatting ?? StructuredFormatting();

  MapAutoCompleteResult copyWith({
    String? description,
    List<MatchedSubstrings>? matchedSubstrings,
    String? placeId,
    String? reference,
    StructuredFormatting? structuredFormatting,
    List<Terms>? terms,
    List<String>? types,
  }) {
    return MapAutoCompleteResult(
      description: description ?? this.description,
      matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
      placeId: placeId ?? this.placeId,
      reference: reference ?? this.reference,
      structuredFormatting: structuredFormatting ?? this.structuredFormatting,
      terms: terms ?? this.terms,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'matched_substrings': matchedSubstrings.map((x) => x.toMap()).toList(),
      'place_id': placeId,
      'reference': reference,
      'structured_formatting': structuredFormatting.toMap(),
      'terms': terms.map((x) => x.toMap()).toList(),
      'types': types,
    };
  }

  factory MapAutoCompleteResult.fromMap(Map<String, dynamic> map) {
    return MapAutoCompleteResult(
        description: map['description'] ?? '',
        matchedSubstrings: List<MatchedSubstrings>.from(
          (map['matched_substrings'] ?? []).map<MatchedSubstrings>((x) => MatchedSubstrings.fromMap(x as Map<String, dynamic>)),
        ),
        placeId: map['place_id'] ?? '',
        reference: map['reference'] ?? '',
        structuredFormatting: StructuredFormatting.fromMap(map['structured_formatting'] ?? {}),
        terms: List<Terms>.from((map['terms'] ?? []).map<Terms>((x) => Terms.fromMap(x as Map<String, dynamic>))),
        types: List<String>.from((map['types'] ?? [])));
  }

  String toJson() => json.encode(toMap());

  factory MapAutoCompleteResult.fromJson(String source) => MapAutoCompleteResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AutoCompleteResult(description: $description, matchedSubstrings: $matchedSubstrings, placeId: $placeId, reference: $reference, structuredFormatting: $structuredFormatting, terms: $terms, types: $types)';
  }

  @override
  bool operator ==(covariant MapAutoCompleteResult other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        listEquals(other.matchedSubstrings, matchedSubstrings) &&
        other.placeId == placeId &&
        other.reference == reference &&
        other.structuredFormatting == structuredFormatting &&
        listEquals(other.terms, terms) &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode {
    return description.hashCode ^ matchedSubstrings.hashCode ^ placeId.hashCode ^ reference.hashCode ^ structuredFormatting.hashCode ^ terms.hashCode ^ types.hashCode;
  }
}

class MatchedSubstrings {
  int length;
  int offset;

  MatchedSubstrings({
    this.length = 0,
    this.offset = 0,
  });

  MatchedSubstrings copyWith({
    int? length,
    int? offset,
  }) {
    return MatchedSubstrings(
      length: length ?? this.length,
      offset: offset ?? this.offset,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'length': length,
      'offset': offset,
    };
  }

  factory MatchedSubstrings.fromMap(Map<String, dynamic> map) {
    return MatchedSubstrings(
      length: map['length'] ?? 0,
      offset: map['offset'] ?? 0,
    );
  }

  factory MatchedSubstrings.fromJson(String source) => MatchedSubstrings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MatchedSubstrings(length: $length, offset: $offset)';

  @override
  bool operator ==(covariant MatchedSubstrings other) {
    if (identical(this, other)) return true;

    return other.length == length && other.offset == offset;
  }

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;

  String toJson() => json.encode(toMap());
}

class StructuredFormatting {
  String mainText;
  List<MatchedSubstrings> mainTextMatchedSubstrings;
  String secondaryText;

  StructuredFormatting({
    this.mainText = '',
    this.mainTextMatchedSubstrings = const [],
    this.secondaryText = '',
  });

  StructuredFormatting copyWith({
    String? mainText,
    List<MatchedSubstrings>? mainTextMatchedSubstrings,
    String? secondaryText,
  }) {
    return StructuredFormatting(
      mainText: mainText ?? this.mainText,
      mainTextMatchedSubstrings: mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
      secondaryText: secondaryText ?? this.secondaryText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'main_text': mainText,
      'main_text_matched_substrings': mainTextMatchedSubstrings.map((x) => x.toMap()).toList(),
      'secondary_text': secondaryText,
    };
  }

  factory StructuredFormatting.fromMap(Map<String, dynamic> map) {
    return StructuredFormatting(
      mainText: map['main_text'] ?? '',
      mainTextMatchedSubstrings: List<MatchedSubstrings>.from(
        (map['main_text_matched_substrings'] ?? []).map<MatchedSubstrings>((x) => MatchedSubstrings.fromMap(x as Map<String, dynamic>)),
      ),
      secondaryText: map['secondary_text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StructuredFormatting.fromJson(String source) => StructuredFormatting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StructuredFormatting(mainText: $mainText, mainTextMatchedSubstrings: $mainTextMatchedSubstrings, secondaryText: $secondaryText)';

  @override
  bool operator ==(covariant StructuredFormatting other) {
    if (identical(this, other)) return true;

    return other.mainText == mainText && listEquals(other.mainTextMatchedSubstrings, mainTextMatchedSubstrings) && other.secondaryText == secondaryText;
  }

  @override
  int get hashCode => mainText.hashCode ^ mainTextMatchedSubstrings.hashCode ^ secondaryText.hashCode;
}

class Terms {
  int offset;
  String value;

  Terms({
    this.offset = 0,
    this.value = '',
  });

  Terms copyWith({
    int? offset,
    String? value,
  }) {
    return Terms(
      offset: offset ?? this.offset,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'value': value,
    };
  }

  factory Terms.fromMap(Map<String, dynamic> map) {
    return Terms(
      offset: map['offset'] ?? 0,
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Terms.fromJson(String source) => Terms.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Terms(offset: $offset, value: $value)';

  @override
  bool operator ==(covariant Terms other) {
    if (identical(this, other)) return true;

    return other.offset == offset && other.value == value;
  }

  @override
  int get hashCode => offset.hashCode ^ value.hashCode;
}
