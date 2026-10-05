// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFuelEntryCollection on Isar {
  IsarCollection<FuelEntry> get fuelEntrys => this.collection();
}

const FuelEntrySchema = CollectionSchema(
  name: r'FuelEntry',
  id: -415304569610854362,
  properties: {
    r'consumption': PropertySchema(
      id: 0,
      name: r'consumption',
      type: IsarType.double,
    ),
    r'currentKm': PropertySchema(
      id: 1,
      name: r'currentKm',
      type: IsarType.long,
    ),
    r'date': PropertySchema(id: 2, name: r'date', type: IsarType.dateTime),
    r'fuelType': PropertySchema(
      id: 3,
      name: r'fuelType',
      type: IsarType.string,
    ),
    r'fullTank': PropertySchema(id: 4, name: r'fullTank', type: IsarType.bool),
    r'liters': PropertySchema(id: 5, name: r'liters', type: IsarType.double),
    r'notes': PropertySchema(id: 6, name: r'notes', type: IsarType.string),
    r'pricePerLiter': PropertySchema(
      id: 7,
      name: r'pricePerLiter',
      type: IsarType.double,
    ),
    r'station': PropertySchema(id: 8, name: r'station', type: IsarType.string),
    r'total': PropertySchema(id: 9, name: r'total', type: IsarType.double),
    r'vehicleId': PropertySchema(
      id: 10,
      name: r'vehicleId',
      type: IsarType.long,
    ),
  },

  estimateSize: _fuelEntryEstimateSize,
  serialize: _fuelEntrySerialize,
  deserialize: _fuelEntryDeserialize,
  deserializeProp: _fuelEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _fuelEntryGetId,
  getLinks: _fuelEntryGetLinks,
  attach: _fuelEntryAttach,
  version: '3.3.2',
);

int _fuelEntryEstimateSize(
  FuelEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fuelType.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.station;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _fuelEntrySerialize(
  FuelEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.consumption);
  writer.writeLong(offsets[1], object.currentKm);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeString(offsets[3], object.fuelType);
  writer.writeBool(offsets[4], object.fullTank);
  writer.writeDouble(offsets[5], object.liters);
  writer.writeString(offsets[6], object.notes);
  writer.writeDouble(offsets[7], object.pricePerLiter);
  writer.writeString(offsets[8], object.station);
  writer.writeDouble(offsets[9], object.total);
  writer.writeLong(offsets[10], object.vehicleId);
}

FuelEntry _fuelEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FuelEntry();
  object.consumption = reader.readDoubleOrNull(offsets[0]);
  object.currentKm = reader.readLong(offsets[1]);
  object.date = reader.readDateTime(offsets[2]);
  object.fuelType = reader.readString(offsets[3]);
  object.fullTank = reader.readBool(offsets[4]);
  object.id = id;
  object.liters = reader.readDouble(offsets[5]);
  object.notes = reader.readStringOrNull(offsets[6]);
  object.pricePerLiter = reader.readDouble(offsets[7]);
  object.station = reader.readStringOrNull(offsets[8]);
  object.total = reader.readDouble(offsets[9]);
  object.vehicleId = reader.readLong(offsets[10]);
  return object;
}

P _fuelEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fuelEntryGetId(FuelEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fuelEntryGetLinks(FuelEntry object) {
  return [];
}

void _fuelEntryAttach(IsarCollection<dynamic> col, Id id, FuelEntry object) {
  object.id = id;
}

extension FuelEntryQueryWhereSort
    on QueryBuilder<FuelEntry, FuelEntry, QWhere> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FuelEntryQueryWhere
    on QueryBuilder<FuelEntry, FuelEntry, QWhereClause> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FuelEntryQueryFilter
    on QueryBuilder<FuelEntry, FuelEntry, QFilterCondition> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  consumptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'consumption'),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  consumptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'consumption'),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> consumptionEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'consumption',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  consumptionGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'consumption',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> consumptionLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'consumption',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> consumptionBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'consumption',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> currentKmEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentKm', value: value),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  currentKmGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentKm',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> currentKmLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentKm',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> currentKmBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentKm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'date',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fuelType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fuelType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fuelType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fuelType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fuelType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fuelType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fuelType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fuelType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fuelTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fuelType', value: ''),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  fuelTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fuelType', value: ''),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> fullTankEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fullTank', value: value),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litersEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'liters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litersGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'liters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litersLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'liters',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litersBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'liters',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  pricePerLiterEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pricePerLiter',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  pricePerLiterGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pricePerLiter',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  pricePerLiterLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pricePerLiter',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  pricePerLiterBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pricePerLiter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'station'),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'station'),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'station',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'station',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'station',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'station',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'station',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'station',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'station',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'station',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> stationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'station', value: ''),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  stationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'station', value: ''),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> totalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'total',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> totalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'total',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> totalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'total',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> totalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'total',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> vehicleIdEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vehicleId', value: value),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
  vehicleIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'vehicleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> vehicleIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'vehicleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> vehicleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'vehicleId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FuelEntryQueryObject
    on QueryBuilder<FuelEntry, FuelEntry, QFilterCondition> {}

extension FuelEntryQueryLinks
    on QueryBuilder<FuelEntry, FuelEntry, QFilterCondition> {}

extension FuelEntryQuerySortBy on QueryBuilder<FuelEntry, FuelEntry, QSortBy> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByConsumption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumption', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByConsumptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumption', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCurrentKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentKm', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCurrentKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentKm', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByFuelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelType', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByFuelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelType', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByFullTank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByFullTankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByLitersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByPricePerLiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByPricePerLiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByStation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByStationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }
}

extension FuelEntryQuerySortThenBy
    on QueryBuilder<FuelEntry, FuelEntry, QSortThenBy> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByConsumption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumption', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByConsumptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumption', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCurrentKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentKm', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCurrentKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentKm', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByFuelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelType', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByFuelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuelType', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByFullTank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByFullTankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullTank', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByLitersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'liters', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByPricePerLiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByPricePerLiterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerLiter', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByStation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByStationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }
}

extension FuelEntryQueryWhereDistinct
    on QueryBuilder<FuelEntry, FuelEntry, QDistinct> {
  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByConsumption() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consumption');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByCurrentKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentKm');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByFuelType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fuelType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByFullTank() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullTank');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByLiters() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'liters');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByPricePerLiter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pricePerLiter');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByStation({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'station', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'total');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleId');
    });
  }
}

extension FuelEntryQueryProperty
    on QueryBuilder<FuelEntry, FuelEntry, QQueryProperty> {
  QueryBuilder<FuelEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FuelEntry, double?, QQueryOperations> consumptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consumption');
    });
  }

  QueryBuilder<FuelEntry, int, QQueryOperations> currentKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentKm');
    });
  }

  QueryBuilder<FuelEntry, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<FuelEntry, String, QQueryOperations> fuelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fuelType');
    });
  }

  QueryBuilder<FuelEntry, bool, QQueryOperations> fullTankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullTank');
    });
  }

  QueryBuilder<FuelEntry, double, QQueryOperations> litersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'liters');
    });
  }

  QueryBuilder<FuelEntry, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<FuelEntry, double, QQueryOperations> pricePerLiterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pricePerLiter');
    });
  }

  QueryBuilder<FuelEntry, String?, QQueryOperations> stationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'station');
    });
  }

  QueryBuilder<FuelEntry, double, QQueryOperations> totalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'total');
    });
  }

  QueryBuilder<FuelEntry, int, QQueryOperations> vehicleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleId');
    });
  }
}
