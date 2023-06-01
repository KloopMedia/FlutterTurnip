// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CampaignTable extends Campaign
    with TableInfo<$CampaignTable, CampaignData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampaignTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptorMeta =
      const VerificationMeta('descriptor');
  @override
  late final GeneratedColumn<String> descriptor = GeneratedColumn<String>(
      'descriptor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logoMeta = const VerificationMeta('logo');
  @override
  late final GeneratedColumn<String> logo = GeneratedColumn<String>(
      'logo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, descriptor, logo];
  @override
  String get aliasedName => _alias ?? 'campaign';
  @override
  String get actualTableName => 'campaign';
  @override
  VerificationContext validateIntegrity(Insertable<CampaignData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('descriptor')) {
      context.handle(
          _descriptorMeta,
          descriptor.isAcceptableOrUnknown(
              data['descriptor']!, _descriptorMeta));
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo']!, _logoMeta));
    } else if (isInserting) {
      context.missing(_logoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CampaignData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CampaignData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      descriptor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descriptor']),
      logo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo'])!,
    );
  }

  @override
  $CampaignTable createAlias(String alias) {
    return $CampaignTable(attachedDatabase, alias);
  }
}

class CampaignData extends DataClass implements Insertable<CampaignData> {
  final int id;
  final String name;
  final String description;
  final String? descriptor;
  final String logo;
  const CampaignData(
      {required this.id,
      required this.name,
      required this.description,
      this.descriptor,
      required this.logo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || descriptor != null) {
      map['descriptor'] = Variable<String>(descriptor);
    }
    map['logo'] = Variable<String>(logo);
    return map;
  }

  CampaignCompanion toCompanion(bool nullToAbsent) {
    return CampaignCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      descriptor: descriptor == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptor),
      logo: Value(logo),
    );
  }

  factory CampaignData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CampaignData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      descriptor: serializer.fromJson<String?>(json['descriptor']),
      logo: serializer.fromJson<String>(json['logo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'descriptor': serializer.toJson<String?>(descriptor),
      'logo': serializer.toJson<String>(logo),
    };
  }

  CampaignData copyWith(
          {int? id,
          String? name,
          String? description,
          Value<String?> descriptor = const Value.absent(),
          String? logo}) =>
      CampaignData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        descriptor: descriptor.present ? descriptor.value : this.descriptor,
        logo: logo ?? this.logo,
      );
  @override
  String toString() {
    return (StringBuffer('CampaignData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('descriptor: $descriptor, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, descriptor, logo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CampaignData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.descriptor == this.descriptor &&
          other.logo == this.logo);
}

class CampaignCompanion extends UpdateCompanion<CampaignData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> descriptor;
  final Value<String> logo;
  const CampaignCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptor = const Value.absent(),
    this.logo = const Value.absent(),
  });
  CampaignCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.descriptor = const Value.absent(),
    required String logo,
  })  : name = Value(name),
        description = Value(description),
        logo = Value(logo);
  static Insertable<CampaignData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? descriptor,
    Expression<String>? logo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (descriptor != null) 'descriptor': descriptor,
      if (logo != null) 'logo': logo,
    });
  }

  CampaignCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String?>? descriptor,
      Value<String>? logo}) {
    return CampaignCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      descriptor: descriptor ?? this.descriptor,
      logo: logo ?? this.logo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptor.present) {
      map['descriptor'] = Variable<String>(descriptor.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String>(logo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('descriptor: $descriptor, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $CampaignTable campaign = $CampaignTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [campaign];
}
