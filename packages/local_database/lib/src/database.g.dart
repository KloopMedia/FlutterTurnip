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
  static const VerificationMeta _joinedMeta = const VerificationMeta('joined');
  @override
  late final GeneratedColumn<bool> joined =
      GeneratedColumn<bool>('joined', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("joined" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _smsCompleteTaskAllowMeta =
      const VerificationMeta('smsCompleteTaskAllow');
  @override
  late final GeneratedColumn<bool> smsCompleteTaskAllow =
      GeneratedColumn<bool>('sms_complete_task_allow', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("sms_complete_task_allow" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _smsPhoneMeta =
      const VerificationMeta('smsPhone');
  @override
  late final GeneratedColumn<String> smsPhone = GeneratedColumn<String>(
      'sms_phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        descriptor,
        logo,
        joined,
        smsCompleteTaskAllow,
        smsPhone
      ];
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
    if (data.containsKey('joined')) {
      context.handle(_joinedMeta,
          joined.isAcceptableOrUnknown(data['joined']!, _joinedMeta));
    } else if (isInserting) {
      context.missing(_joinedMeta);
    }
    if (data.containsKey('sms_complete_task_allow')) {
      context.handle(
          _smsCompleteTaskAllowMeta,
          smsCompleteTaskAllow.isAcceptableOrUnknown(
              data['sms_complete_task_allow']!, _smsCompleteTaskAllowMeta));
    }
    if (data.containsKey('sms_phone')) {
      context.handle(_smsPhoneMeta,
          smsPhone.isAcceptableOrUnknown(data['sms_phone']!, _smsPhoneMeta));
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
      joined: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}joined'])!,
      smsCompleteTaskAllow: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}sms_complete_task_allow'])!,
      smsPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sms_phone']),
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
  final bool joined;
  final bool smsCompleteTaskAllow;
  final String? smsPhone;
  const CampaignData(
      {required this.id,
      required this.name,
      required this.description,
      this.descriptor,
      required this.logo,
      required this.joined,
      required this.smsCompleteTaskAllow,
      this.smsPhone});
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
    map['joined'] = Variable<bool>(joined);
    map['sms_complete_task_allow'] = Variable<bool>(smsCompleteTaskAllow);
    if (!nullToAbsent || smsPhone != null) {
      map['sms_phone'] = Variable<String>(smsPhone);
    }
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
      joined: Value(joined),
      smsCompleteTaskAllow: Value(smsCompleteTaskAllow),
      smsPhone: smsPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(smsPhone),
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
      joined: serializer.fromJson<bool>(json['joined']),
      smsCompleteTaskAllow:
          serializer.fromJson<bool>(json['smsCompleteTaskAllow']),
      smsPhone: serializer.fromJson<String?>(json['smsPhone']),
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
      'joined': serializer.toJson<bool>(joined),
      'smsCompleteTaskAllow': serializer.toJson<bool>(smsCompleteTaskAllow),
      'smsPhone': serializer.toJson<String?>(smsPhone),
    };
  }

  CampaignData copyWith(
          {int? id,
          String? name,
          String? description,
          Value<String?> descriptor = const Value.absent(),
          String? logo,
          bool? joined,
          bool? smsCompleteTaskAllow,
          Value<String?> smsPhone = const Value.absent()}) =>
      CampaignData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        descriptor: descriptor.present ? descriptor.value : this.descriptor,
        logo: logo ?? this.logo,
        joined: joined ?? this.joined,
        smsCompleteTaskAllow: smsCompleteTaskAllow ?? this.smsCompleteTaskAllow,
        smsPhone: smsPhone.present ? smsPhone.value : this.smsPhone,
      );
  @override
  String toString() {
    return (StringBuffer('CampaignData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('descriptor: $descriptor, ')
          ..write('logo: $logo, ')
          ..write('joined: $joined, ')
          ..write('smsCompleteTaskAllow: $smsCompleteTaskAllow, ')
          ..write('smsPhone: $smsPhone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, descriptor, logo,
      joined, smsCompleteTaskAllow, smsPhone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CampaignData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.descriptor == this.descriptor &&
          other.logo == this.logo &&
          other.joined == this.joined &&
          other.smsCompleteTaskAllow == this.smsCompleteTaskAllow &&
          other.smsPhone == this.smsPhone);
}

class CampaignCompanion extends UpdateCompanion<CampaignData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> descriptor;
  final Value<String> logo;
  final Value<bool> joined;
  final Value<bool> smsCompleteTaskAllow;
  final Value<String?> smsPhone;
  const CampaignCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptor = const Value.absent(),
    this.logo = const Value.absent(),
    this.joined = const Value.absent(),
    this.smsCompleteTaskAllow = const Value.absent(),
    this.smsPhone = const Value.absent(),
  });
  CampaignCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.descriptor = const Value.absent(),
    required String logo,
    required bool joined,
    this.smsCompleteTaskAllow = const Value.absent(),
    this.smsPhone = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        logo = Value(logo),
        joined = Value(joined);
  static Insertable<CampaignData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? descriptor,
    Expression<String>? logo,
    Expression<bool>? joined,
    Expression<bool>? smsCompleteTaskAllow,
    Expression<String>? smsPhone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (descriptor != null) 'descriptor': descriptor,
      if (logo != null) 'logo': logo,
      if (joined != null) 'joined': joined,
      if (smsCompleteTaskAllow != null)
        'sms_complete_task_allow': smsCompleteTaskAllow,
      if (smsPhone != null) 'sms_phone': smsPhone,
    });
  }

  CampaignCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String?>? descriptor,
      Value<String>? logo,
      Value<bool>? joined,
      Value<bool>? smsCompleteTaskAllow,
      Value<String?>? smsPhone}) {
    return CampaignCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      descriptor: descriptor ?? this.descriptor,
      logo: logo ?? this.logo,
      joined: joined ?? this.joined,
      smsCompleteTaskAllow: smsCompleteTaskAllow ?? this.smsCompleteTaskAllow,
      smsPhone: smsPhone ?? this.smsPhone,
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
    if (joined.present) {
      map['joined'] = Variable<bool>(joined.value);
    }
    if (smsCompleteTaskAllow.present) {
      map['sms_complete_task_allow'] =
          Variable<bool>(smsCompleteTaskAllow.value);
    }
    if (smsPhone.present) {
      map['sms_phone'] = Variable<String>(smsPhone.value);
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
          ..write('logo: $logo, ')
          ..write('joined: $joined, ')
          ..write('smsCompleteTaskAllow: $smsCompleteTaskAllow, ')
          ..write('smsPhone: $smsPhone')
          ..write(')'))
        .toString();
  }
}

class $TaskStageTable extends TaskStage
    with TableInfo<$TaskStageTable, TaskStageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskStageTable(this.attachedDatabase, [this._alias]);
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
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _chainMeta = const VerificationMeta('chain');
  @override
  late final GeneratedColumn<int> chain = GeneratedColumn<int>(
      'chain', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _campaignMeta =
      const VerificationMeta('campaign');
  @override
  late final GeneratedColumn<int> campaign = GeneratedColumn<int>(
      'campaign', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _richTextMeta =
      const VerificationMeta('richText');
  @override
  late final GeneratedColumn<String> richText = GeneratedColumn<String>(
      'rich_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardJsonSchemaMeta =
      const VerificationMeta('cardJsonSchema');
  @override
  late final GeneratedColumn<String> cardJsonSchema = GeneratedColumn<String>(
      'card_json_schema', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardUiSchemaMeta =
      const VerificationMeta('cardUiSchema');
  @override
  late final GeneratedColumn<String> cardUiSchema = GeneratedColumn<String>(
      'card_ui_schema', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _jsonSchemaMeta =
      const VerificationMeta('jsonSchema');
  @override
  late final GeneratedColumn<String> jsonSchema = GeneratedColumn<String>(
      'json_schema', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uiSchemaMeta =
      const VerificationMeta('uiSchema');
  @override
  late final GeneratedColumn<String> uiSchema = GeneratedColumn<String>(
      'ui_schema', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _availableFromMeta =
      const VerificationMeta('availableFrom');
  @override
  late final GeneratedColumn<DateTime> availableFrom =
      GeneratedColumn<DateTime>('available_from', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _availableToMeta =
      const VerificationMeta('availableTo');
  @override
  late final GeneratedColumn<DateTime> availableTo = GeneratedColumn<DateTime>(
      'available_to', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _stageTypeMeta =
      const VerificationMeta('stageType');
  @override
  late final GeneratedColumn<String> stageType = GeneratedColumn<String>(
      'stage_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _openLimitMeta =
      const VerificationMeta('openLimit');
  @override
  late final GeneratedColumn<int> openLimit = GeneratedColumn<int>(
      'open_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalLimitMeta =
      const VerificationMeta('totalLimit');
  @override
  late final GeneratedColumn<int> totalLimit = GeneratedColumn<int>(
      'total_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        chain,
        campaign,
        richText,
        cardJsonSchema,
        cardUiSchema,
        jsonSchema,
        uiSchema,
        availableFrom,
        availableTo,
        stageType,
        openLimit,
        totalLimit
      ];
  @override
  String get aliasedName => _alias ?? 'task_stage';
  @override
  String get actualTableName => 'task_stage';
  @override
  VerificationContext validateIntegrity(Insertable<TaskStageData> instance,
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
    }
    if (data.containsKey('chain')) {
      context.handle(
          _chainMeta, chain.isAcceptableOrUnknown(data['chain']!, _chainMeta));
    } else if (isInserting) {
      context.missing(_chainMeta);
    }
    if (data.containsKey('campaign')) {
      context.handle(_campaignMeta,
          campaign.isAcceptableOrUnknown(data['campaign']!, _campaignMeta));
    } else if (isInserting) {
      context.missing(_campaignMeta);
    }
    if (data.containsKey('rich_text')) {
      context.handle(_richTextMeta,
          richText.isAcceptableOrUnknown(data['rich_text']!, _richTextMeta));
    }
    if (data.containsKey('card_json_schema')) {
      context.handle(
          _cardJsonSchemaMeta,
          cardJsonSchema.isAcceptableOrUnknown(
              data['card_json_schema']!, _cardJsonSchemaMeta));
    }
    if (data.containsKey('card_ui_schema')) {
      context.handle(
          _cardUiSchemaMeta,
          cardUiSchema.isAcceptableOrUnknown(
              data['card_ui_schema']!, _cardUiSchemaMeta));
    }
    if (data.containsKey('json_schema')) {
      context.handle(
          _jsonSchemaMeta,
          jsonSchema.isAcceptableOrUnknown(
              data['json_schema']!, _jsonSchemaMeta));
    }
    if (data.containsKey('ui_schema')) {
      context.handle(_uiSchemaMeta,
          uiSchema.isAcceptableOrUnknown(data['ui_schema']!, _uiSchemaMeta));
    }
    if (data.containsKey('available_from')) {
      context.handle(
          _availableFromMeta,
          availableFrom.isAcceptableOrUnknown(
              data['available_from']!, _availableFromMeta));
    }
    if (data.containsKey('available_to')) {
      context.handle(
          _availableToMeta,
          availableTo.isAcceptableOrUnknown(
              data['available_to']!, _availableToMeta));
    }
    if (data.containsKey('stage_type')) {
      context.handle(_stageTypeMeta,
          stageType.isAcceptableOrUnknown(data['stage_type']!, _stageTypeMeta));
    }
    if (data.containsKey('open_limit')) {
      context.handle(_openLimitMeta,
          openLimit.isAcceptableOrUnknown(data['open_limit']!, _openLimitMeta));
    } else if (isInserting) {
      context.missing(_openLimitMeta);
    }
    if (data.containsKey('total_limit')) {
      context.handle(
          _totalLimitMeta,
          totalLimit.isAcceptableOrUnknown(
              data['total_limit']!, _totalLimitMeta));
    } else if (isInserting) {
      context.missing(_totalLimitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskStageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskStageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      chain: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chain'])!,
      campaign: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}campaign'])!,
      richText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rich_text']),
      cardJsonSchema: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}card_json_schema']),
      cardUiSchema: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_ui_schema']),
      jsonSchema: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_schema']),
      uiSchema: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ui_schema']),
      availableFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}available_from']),
      availableTo: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}available_to']),
      stageType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stage_type']),
      openLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}open_limit'])!,
      totalLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_limit'])!,
    );
  }

  @override
  $TaskStageTable createAlias(String alias) {
    return $TaskStageTable(attachedDatabase, alias);
  }
}

class TaskStageData extends DataClass implements Insertable<TaskStageData> {
  final int id;
  final String name;
  final String? description;
  final int chain;
  final int campaign;
  final String? richText;
  final String? cardJsonSchema;
  final String? cardUiSchema;
  final String? jsonSchema;
  final String? uiSchema;
  final DateTime? availableFrom;
  final DateTime? availableTo;
  final String? stageType;
  final int openLimit;
  final int totalLimit;
  const TaskStageData(
      {required this.id,
      required this.name,
      this.description,
      required this.chain,
      required this.campaign,
      this.richText,
      this.cardJsonSchema,
      this.cardUiSchema,
      this.jsonSchema,
      this.uiSchema,
      this.availableFrom,
      this.availableTo,
      this.stageType,
      required this.openLimit,
      required this.totalLimit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['chain'] = Variable<int>(chain);
    map['campaign'] = Variable<int>(campaign);
    if (!nullToAbsent || richText != null) {
      map['rich_text'] = Variable<String>(richText);
    }
    if (!nullToAbsent || cardJsonSchema != null) {
      map['card_json_schema'] = Variable<String>(cardJsonSchema);
    }
    if (!nullToAbsent || cardUiSchema != null) {
      map['card_ui_schema'] = Variable<String>(cardUiSchema);
    }
    if (!nullToAbsent || jsonSchema != null) {
      map['json_schema'] = Variable<String>(jsonSchema);
    }
    if (!nullToAbsent || uiSchema != null) {
      map['ui_schema'] = Variable<String>(uiSchema);
    }
    if (!nullToAbsent || availableFrom != null) {
      map['available_from'] = Variable<DateTime>(availableFrom);
    }
    if (!nullToAbsent || availableTo != null) {
      map['available_to'] = Variable<DateTime>(availableTo);
    }
    if (!nullToAbsent || stageType != null) {
      map['stage_type'] = Variable<String>(stageType);
    }
    map['open_limit'] = Variable<int>(openLimit);
    map['total_limit'] = Variable<int>(totalLimit);
    return map;
  }

  TaskStageCompanion toCompanion(bool nullToAbsent) {
    return TaskStageCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      chain: Value(chain),
      campaign: Value(campaign),
      richText: richText == null && nullToAbsent
          ? const Value.absent()
          : Value(richText),
      cardJsonSchema: cardJsonSchema == null && nullToAbsent
          ? const Value.absent()
          : Value(cardJsonSchema),
      cardUiSchema: cardUiSchema == null && nullToAbsent
          ? const Value.absent()
          : Value(cardUiSchema),
      jsonSchema: jsonSchema == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonSchema),
      uiSchema: uiSchema == null && nullToAbsent
          ? const Value.absent()
          : Value(uiSchema),
      availableFrom: availableFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(availableFrom),
      availableTo: availableTo == null && nullToAbsent
          ? const Value.absent()
          : Value(availableTo),
      stageType: stageType == null && nullToAbsent
          ? const Value.absent()
          : Value(stageType),
      openLimit: Value(openLimit),
      totalLimit: Value(totalLimit),
    );
  }

  factory TaskStageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskStageData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      chain: serializer.fromJson<int>(json['chain']),
      campaign: serializer.fromJson<int>(json['campaign']),
      richText: serializer.fromJson<String?>(json['richText']),
      cardJsonSchema: serializer.fromJson<String?>(json['cardJsonSchema']),
      cardUiSchema: serializer.fromJson<String?>(json['cardUiSchema']),
      jsonSchema: serializer.fromJson<String?>(json['jsonSchema']),
      uiSchema: serializer.fromJson<String?>(json['uiSchema']),
      availableFrom: serializer.fromJson<DateTime?>(json['availableFrom']),
      availableTo: serializer.fromJson<DateTime?>(json['availableTo']),
      stageType: serializer.fromJson<String?>(json['stageType']),
      openLimit: serializer.fromJson<int>(json['openLimit']),
      totalLimit: serializer.fromJson<int>(json['totalLimit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'chain': serializer.toJson<int>(chain),
      'campaign': serializer.toJson<int>(campaign),
      'richText': serializer.toJson<String?>(richText),
      'cardJsonSchema': serializer.toJson<String?>(cardJsonSchema),
      'cardUiSchema': serializer.toJson<String?>(cardUiSchema),
      'jsonSchema': serializer.toJson<String?>(jsonSchema),
      'uiSchema': serializer.toJson<String?>(uiSchema),
      'availableFrom': serializer.toJson<DateTime?>(availableFrom),
      'availableTo': serializer.toJson<DateTime?>(availableTo),
      'stageType': serializer.toJson<String?>(stageType),
      'openLimit': serializer.toJson<int>(openLimit),
      'totalLimit': serializer.toJson<int>(totalLimit),
    };
  }

  TaskStageData copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          int? chain,
          int? campaign,
          Value<String?> richText = const Value.absent(),
          Value<String?> cardJsonSchema = const Value.absent(),
          Value<String?> cardUiSchema = const Value.absent(),
          Value<String?> jsonSchema = const Value.absent(),
          Value<String?> uiSchema = const Value.absent(),
          Value<DateTime?> availableFrom = const Value.absent(),
          Value<DateTime?> availableTo = const Value.absent(),
          Value<String?> stageType = const Value.absent(),
          int? openLimit,
          int? totalLimit}) =>
      TaskStageData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        chain: chain ?? this.chain,
        campaign: campaign ?? this.campaign,
        richText: richText.present ? richText.value : this.richText,
        cardJsonSchema:
            cardJsonSchema.present ? cardJsonSchema.value : this.cardJsonSchema,
        cardUiSchema:
            cardUiSchema.present ? cardUiSchema.value : this.cardUiSchema,
        jsonSchema: jsonSchema.present ? jsonSchema.value : this.jsonSchema,
        uiSchema: uiSchema.present ? uiSchema.value : this.uiSchema,
        availableFrom:
            availableFrom.present ? availableFrom.value : this.availableFrom,
        availableTo: availableTo.present ? availableTo.value : this.availableTo,
        stageType: stageType.present ? stageType.value : this.stageType,
        openLimit: openLimit ?? this.openLimit,
        totalLimit: totalLimit ?? this.totalLimit,
      );
  @override
  String toString() {
    return (StringBuffer('TaskStageData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('chain: $chain, ')
          ..write('campaign: $campaign, ')
          ..write('richText: $richText, ')
          ..write('cardJsonSchema: $cardJsonSchema, ')
          ..write('cardUiSchema: $cardUiSchema, ')
          ..write('jsonSchema: $jsonSchema, ')
          ..write('uiSchema: $uiSchema, ')
          ..write('availableFrom: $availableFrom, ')
          ..write('availableTo: $availableTo, ')
          ..write('stageType: $stageType, ')
          ..write('openLimit: $openLimit, ')
          ..write('totalLimit: $totalLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      chain,
      campaign,
      richText,
      cardJsonSchema,
      cardUiSchema,
      jsonSchema,
      uiSchema,
      availableFrom,
      availableTo,
      stageType,
      openLimit,
      totalLimit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskStageData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.chain == this.chain &&
          other.campaign == this.campaign &&
          other.richText == this.richText &&
          other.cardJsonSchema == this.cardJsonSchema &&
          other.cardUiSchema == this.cardUiSchema &&
          other.jsonSchema == this.jsonSchema &&
          other.uiSchema == this.uiSchema &&
          other.availableFrom == this.availableFrom &&
          other.availableTo == this.availableTo &&
          other.stageType == this.stageType &&
          other.openLimit == this.openLimit &&
          other.totalLimit == this.totalLimit);
}

class TaskStageCompanion extends UpdateCompanion<TaskStageData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> chain;
  final Value<int> campaign;
  final Value<String?> richText;
  final Value<String?> cardJsonSchema;
  final Value<String?> cardUiSchema;
  final Value<String?> jsonSchema;
  final Value<String?> uiSchema;
  final Value<DateTime?> availableFrom;
  final Value<DateTime?> availableTo;
  final Value<String?> stageType;
  final Value<int> openLimit;
  final Value<int> totalLimit;
  const TaskStageCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.chain = const Value.absent(),
    this.campaign = const Value.absent(),
    this.richText = const Value.absent(),
    this.cardJsonSchema = const Value.absent(),
    this.cardUiSchema = const Value.absent(),
    this.jsonSchema = const Value.absent(),
    this.uiSchema = const Value.absent(),
    this.availableFrom = const Value.absent(),
    this.availableTo = const Value.absent(),
    this.stageType = const Value.absent(),
    this.openLimit = const Value.absent(),
    this.totalLimit = const Value.absent(),
  });
  TaskStageCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required int chain,
    required int campaign,
    this.richText = const Value.absent(),
    this.cardJsonSchema = const Value.absent(),
    this.cardUiSchema = const Value.absent(),
    this.jsonSchema = const Value.absent(),
    this.uiSchema = const Value.absent(),
    this.availableFrom = const Value.absent(),
    this.availableTo = const Value.absent(),
    this.stageType = const Value.absent(),
    required int openLimit,
    required int totalLimit,
  })  : name = Value(name),
        chain = Value(chain),
        campaign = Value(campaign),
        openLimit = Value(openLimit),
        totalLimit = Value(totalLimit);
  static Insertable<TaskStageData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? chain,
    Expression<int>? campaign,
    Expression<String>? richText,
    Expression<String>? cardJsonSchema,
    Expression<String>? cardUiSchema,
    Expression<String>? jsonSchema,
    Expression<String>? uiSchema,
    Expression<DateTime>? availableFrom,
    Expression<DateTime>? availableTo,
    Expression<String>? stageType,
    Expression<int>? openLimit,
    Expression<int>? totalLimit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (chain != null) 'chain': chain,
      if (campaign != null) 'campaign': campaign,
      if (richText != null) 'rich_text': richText,
      if (cardJsonSchema != null) 'card_json_schema': cardJsonSchema,
      if (cardUiSchema != null) 'card_ui_schema': cardUiSchema,
      if (jsonSchema != null) 'json_schema': jsonSchema,
      if (uiSchema != null) 'ui_schema': uiSchema,
      if (availableFrom != null) 'available_from': availableFrom,
      if (availableTo != null) 'available_to': availableTo,
      if (stageType != null) 'stage_type': stageType,
      if (openLimit != null) 'open_limit': openLimit,
      if (totalLimit != null) 'total_limit': totalLimit,
    });
  }

  TaskStageCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<int>? chain,
      Value<int>? campaign,
      Value<String?>? richText,
      Value<String?>? cardJsonSchema,
      Value<String?>? cardUiSchema,
      Value<String?>? jsonSchema,
      Value<String?>? uiSchema,
      Value<DateTime?>? availableFrom,
      Value<DateTime?>? availableTo,
      Value<String?>? stageType,
      Value<int>? openLimit,
      Value<int>? totalLimit}) {
    return TaskStageCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      chain: chain ?? this.chain,
      campaign: campaign ?? this.campaign,
      richText: richText ?? this.richText,
      cardJsonSchema: cardJsonSchema ?? this.cardJsonSchema,
      cardUiSchema: cardUiSchema ?? this.cardUiSchema,
      jsonSchema: jsonSchema ?? this.jsonSchema,
      uiSchema: uiSchema ?? this.uiSchema,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
      stageType: stageType ?? this.stageType,
      openLimit: openLimit ?? this.openLimit,
      totalLimit: totalLimit ?? this.totalLimit,
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
    if (chain.present) {
      map['chain'] = Variable<int>(chain.value);
    }
    if (campaign.present) {
      map['campaign'] = Variable<int>(campaign.value);
    }
    if (richText.present) {
      map['rich_text'] = Variable<String>(richText.value);
    }
    if (cardJsonSchema.present) {
      map['card_json_schema'] = Variable<String>(cardJsonSchema.value);
    }
    if (cardUiSchema.present) {
      map['card_ui_schema'] = Variable<String>(cardUiSchema.value);
    }
    if (jsonSchema.present) {
      map['json_schema'] = Variable<String>(jsonSchema.value);
    }
    if (uiSchema.present) {
      map['ui_schema'] = Variable<String>(uiSchema.value);
    }
    if (availableFrom.present) {
      map['available_from'] = Variable<DateTime>(availableFrom.value);
    }
    if (availableTo.present) {
      map['available_to'] = Variable<DateTime>(availableTo.value);
    }
    if (stageType.present) {
      map['stage_type'] = Variable<String>(stageType.value);
    }
    if (openLimit.present) {
      map['open_limit'] = Variable<int>(openLimit.value);
    }
    if (totalLimit.present) {
      map['total_limit'] = Variable<int>(totalLimit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskStageCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('chain: $chain, ')
          ..write('campaign: $campaign, ')
          ..write('richText: $richText, ')
          ..write('cardJsonSchema: $cardJsonSchema, ')
          ..write('cardUiSchema: $cardUiSchema, ')
          ..write('jsonSchema: $jsonSchema, ')
          ..write('uiSchema: $uiSchema, ')
          ..write('availableFrom: $availableFrom, ')
          ..write('availableTo: $availableTo, ')
          ..write('stageType: $stageType, ')
          ..write('openLimit: $openLimit, ')
          ..write('totalLimit: $totalLimit')
          ..write(')'))
        .toString();
  }
}

class $TaskTable extends Task with TableInfo<$TaskTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete =
      GeneratedColumn<bool>('complete', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("complete" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _reopenedMeta =
      const VerificationMeta('reopened');
  @override
  late final GeneratedColumn<bool> reopened =
      GeneratedColumn<bool>('reopened', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("reopened" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<int> stage = GeneratedColumn<int>(
      'stage', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES task_stage (id)'));
  static const VerificationMeta _campaignMeta =
      const VerificationMeta('campaign');
  @override
  late final GeneratedColumn<int> campaign = GeneratedColumn<int>(
      'campaign', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES campaign (id)'));
  static const VerificationMeta _responsesMeta =
      const VerificationMeta('responses');
  @override
  late final GeneratedColumn<String> responses = GeneratedColumn<String>(
      'responses', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _jsonSchemaMeta =
      const VerificationMeta('jsonSchema');
  @override
  late final GeneratedColumn<String> jsonSchema = GeneratedColumn<String>(
      'json_schema', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uiSchemaMeta =
      const VerificationMeta('uiSchema');
  @override
  late final GeneratedColumn<String> uiSchema = GeneratedColumn<String>(
      'ui_schema', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdOfflineMeta =
      const VerificationMeta('createdOffline');
  @override
  late final GeneratedColumn<bool> createdOffline =
      GeneratedColumn<bool>('created_offline', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("created_offline" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        complete,
        reopened,
        stage,
        campaign,
        responses,
        jsonSchema,
        uiSchema,
        createdAt,
        updatedAt,
        createdOffline
      ];
  @override
  String get aliasedName => _alias ?? 'task';
  @override
  String get actualTableName => 'task';
  @override
  VerificationContext validateIntegrity(Insertable<TaskData> instance,
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
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    } else if (isInserting) {
      context.missing(_completeMeta);
    }
    if (data.containsKey('reopened')) {
      context.handle(_reopenedMeta,
          reopened.isAcceptableOrUnknown(data['reopened']!, _reopenedMeta));
    } else if (isInserting) {
      context.missing(_reopenedMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
          _stageMeta, stage.isAcceptableOrUnknown(data['stage']!, _stageMeta));
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('campaign')) {
      context.handle(_campaignMeta,
          campaign.isAcceptableOrUnknown(data['campaign']!, _campaignMeta));
    } else if (isInserting) {
      context.missing(_campaignMeta);
    }
    if (data.containsKey('responses')) {
      context.handle(_responsesMeta,
          responses.isAcceptableOrUnknown(data['responses']!, _responsesMeta));
    }
    if (data.containsKey('json_schema')) {
      context.handle(
          _jsonSchemaMeta,
          jsonSchema.isAcceptableOrUnknown(
              data['json_schema']!, _jsonSchemaMeta));
    }
    if (data.containsKey('ui_schema')) {
      context.handle(_uiSchemaMeta,
          uiSchema.isAcceptableOrUnknown(data['ui_schema']!, _uiSchemaMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('created_offline')) {
      context.handle(
          _createdOfflineMeta,
          createdOffline.isAcceptableOrUnknown(
              data['created_offline']!, _createdOfflineMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
      reopened: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reopened'])!,
      stage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stage'])!,
      campaign: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}campaign'])!,
      responses: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}responses']),
      jsonSchema: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_schema']),
      uiSchema: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ui_schema']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      createdOffline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}created_offline'])!,
    );
  }

  @override
  $TaskTable createAlias(String alias) {
    return $TaskTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final int id;
  final String name;
  final bool complete;
  final bool reopened;
  final int stage;
  final int campaign;
  final String? responses;
  final String? jsonSchema;
  final String? uiSchema;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool createdOffline;
  const TaskData(
      {required this.id,
      required this.name,
      required this.complete,
      required this.reopened,
      required this.stage,
      required this.campaign,
      this.responses,
      this.jsonSchema,
      this.uiSchema,
      this.createdAt,
      this.updatedAt,
      required this.createdOffline});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['complete'] = Variable<bool>(complete);
    map['reopened'] = Variable<bool>(reopened);
    map['stage'] = Variable<int>(stage);
    map['campaign'] = Variable<int>(campaign);
    if (!nullToAbsent || responses != null) {
      map['responses'] = Variable<String>(responses);
    }
    if (!nullToAbsent || jsonSchema != null) {
      map['json_schema'] = Variable<String>(jsonSchema);
    }
    if (!nullToAbsent || uiSchema != null) {
      map['ui_schema'] = Variable<String>(uiSchema);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['created_offline'] = Variable<bool>(createdOffline);
    return map;
  }

  TaskCompanion toCompanion(bool nullToAbsent) {
    return TaskCompanion(
      id: Value(id),
      name: Value(name),
      complete: Value(complete),
      reopened: Value(reopened),
      stage: Value(stage),
      campaign: Value(campaign),
      responses: responses == null && nullToAbsent
          ? const Value.absent()
          : Value(responses),
      jsonSchema: jsonSchema == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonSchema),
      uiSchema: uiSchema == null && nullToAbsent
          ? const Value.absent()
          : Value(uiSchema),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      createdOffline: Value(createdOffline),
    );
  }

  factory TaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      complete: serializer.fromJson<bool>(json['complete']),
      reopened: serializer.fromJson<bool>(json['reopened']),
      stage: serializer.fromJson<int>(json['stage']),
      campaign: serializer.fromJson<int>(json['campaign']),
      responses: serializer.fromJson<String?>(json['responses']),
      jsonSchema: serializer.fromJson<String?>(json['jsonSchema']),
      uiSchema: serializer.fromJson<String?>(json['uiSchema']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      createdOffline: serializer.fromJson<bool>(json['createdOffline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'complete': serializer.toJson<bool>(complete),
      'reopened': serializer.toJson<bool>(reopened),
      'stage': serializer.toJson<int>(stage),
      'campaign': serializer.toJson<int>(campaign),
      'responses': serializer.toJson<String?>(responses),
      'jsonSchema': serializer.toJson<String?>(jsonSchema),
      'uiSchema': serializer.toJson<String?>(uiSchema),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'createdOffline': serializer.toJson<bool>(createdOffline),
    };
  }

  TaskData copyWith(
          {int? id,
          String? name,
          bool? complete,
          bool? reopened,
          int? stage,
          int? campaign,
          Value<String?> responses = const Value.absent(),
          Value<String?> jsonSchema = const Value.absent(),
          Value<String?> uiSchema = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          bool? createdOffline}) =>
      TaskData(
        id: id ?? this.id,
        name: name ?? this.name,
        complete: complete ?? this.complete,
        reopened: reopened ?? this.reopened,
        stage: stage ?? this.stage,
        campaign: campaign ?? this.campaign,
        responses: responses.present ? responses.value : this.responses,
        jsonSchema: jsonSchema.present ? jsonSchema.value : this.jsonSchema,
        uiSchema: uiSchema.present ? uiSchema.value : this.uiSchema,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        createdOffline: createdOffline ?? this.createdOffline,
      );
  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('complete: $complete, ')
          ..write('reopened: $reopened, ')
          ..write('stage: $stage, ')
          ..write('campaign: $campaign, ')
          ..write('responses: $responses, ')
          ..write('jsonSchema: $jsonSchema, ')
          ..write('uiSchema: $uiSchema, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdOffline: $createdOffline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, complete, reopened, stage, campaign,
      responses, jsonSchema, uiSchema, createdAt, updatedAt, createdOffline);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.name == this.name &&
          other.complete == this.complete &&
          other.reopened == this.reopened &&
          other.stage == this.stage &&
          other.campaign == this.campaign &&
          other.responses == this.responses &&
          other.jsonSchema == this.jsonSchema &&
          other.uiSchema == this.uiSchema &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdOffline == this.createdOffline);
}

class TaskCompanion extends UpdateCompanion<TaskData> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> complete;
  final Value<bool> reopened;
  final Value<int> stage;
  final Value<int> campaign;
  final Value<String?> responses;
  final Value<String?> jsonSchema;
  final Value<String?> uiSchema;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> createdOffline;
  const TaskCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.complete = const Value.absent(),
    this.reopened = const Value.absent(),
    this.stage = const Value.absent(),
    this.campaign = const Value.absent(),
    this.responses = const Value.absent(),
    this.jsonSchema = const Value.absent(),
    this.uiSchema = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdOffline = const Value.absent(),
  });
  TaskCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required bool complete,
    required bool reopened,
    required int stage,
    required int campaign,
    this.responses = const Value.absent(),
    this.jsonSchema = const Value.absent(),
    this.uiSchema = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdOffline = const Value.absent(),
  })  : name = Value(name),
        complete = Value(complete),
        reopened = Value(reopened),
        stage = Value(stage),
        campaign = Value(campaign);
  static Insertable<TaskData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? complete,
    Expression<bool>? reopened,
    Expression<int>? stage,
    Expression<int>? campaign,
    Expression<String>? responses,
    Expression<String>? jsonSchema,
    Expression<String>? uiSchema,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? createdOffline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (complete != null) 'complete': complete,
      if (reopened != null) 'reopened': reopened,
      if (stage != null) 'stage': stage,
      if (campaign != null) 'campaign': campaign,
      if (responses != null) 'responses': responses,
      if (jsonSchema != null) 'json_schema': jsonSchema,
      if (uiSchema != null) 'ui_schema': uiSchema,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdOffline != null) 'created_offline': createdOffline,
    });
  }

  TaskCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? complete,
      Value<bool>? reopened,
      Value<int>? stage,
      Value<int>? campaign,
      Value<String?>? responses,
      Value<String?>? jsonSchema,
      Value<String?>? uiSchema,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<bool>? createdOffline}) {
    return TaskCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      complete: complete ?? this.complete,
      reopened: reopened ?? this.reopened,
      stage: stage ?? this.stage,
      campaign: campaign ?? this.campaign,
      responses: responses ?? this.responses,
      jsonSchema: jsonSchema ?? this.jsonSchema,
      uiSchema: uiSchema ?? this.uiSchema,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdOffline: createdOffline ?? this.createdOffline,
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
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    if (reopened.present) {
      map['reopened'] = Variable<bool>(reopened.value);
    }
    if (stage.present) {
      map['stage'] = Variable<int>(stage.value);
    }
    if (campaign.present) {
      map['campaign'] = Variable<int>(campaign.value);
    }
    if (responses.present) {
      map['responses'] = Variable<String>(responses.value);
    }
    if (jsonSchema.present) {
      map['json_schema'] = Variable<String>(jsonSchema.value);
    }
    if (uiSchema.present) {
      map['ui_schema'] = Variable<String>(uiSchema.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdOffline.present) {
      map['created_offline'] = Variable<bool>(createdOffline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('complete: $complete, ')
          ..write('reopened: $reopened, ')
          ..write('stage: $stage, ')
          ..write('campaign: $campaign, ')
          ..write('responses: $responses, ')
          ..write('jsonSchema: $jsonSchema, ')
          ..write('uiSchema: $uiSchema, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdOffline: $createdOffline')
          ..write(')'))
        .toString();
  }
}

class $RelevantTaskStageTable extends RelevantTaskStage
    with TableInfo<$RelevantTaskStageTable, RelevantTaskStageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelevantTaskStageTable(this.attachedDatabase, [this._alias]);
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
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _chainMeta = const VerificationMeta('chain');
  @override
  late final GeneratedColumn<int> chain = GeneratedColumn<int>(
      'chain', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _campaignMeta =
      const VerificationMeta('campaign');
  @override
  late final GeneratedColumn<int> campaign = GeneratedColumn<int>(
      'campaign', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _availableFromMeta =
      const VerificationMeta('availableFrom');
  @override
  late final GeneratedColumn<DateTime> availableFrom =
      GeneratedColumn<DateTime>('available_from', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _availableToMeta =
      const VerificationMeta('availableTo');
  @override
  late final GeneratedColumn<DateTime> availableTo = GeneratedColumn<DateTime>(
      'available_to', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _stageTypeMeta =
      const VerificationMeta('stageType');
  @override
  late final GeneratedColumn<String> stageType = GeneratedColumn<String>(
      'stage_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _openLimitMeta =
      const VerificationMeta('openLimit');
  @override
  late final GeneratedColumn<int> openLimit = GeneratedColumn<int>(
      'open_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalLimitMeta =
      const VerificationMeta('totalLimit');
  @override
  late final GeneratedColumn<int> totalLimit = GeneratedColumn<int>(
      'total_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        chain,
        campaign,
        availableFrom,
        availableTo,
        stageType,
        openLimit,
        totalLimit
      ];
  @override
  String get aliasedName => _alias ?? 'relevant_task_stage';
  @override
  String get actualTableName => 'relevant_task_stage';
  @override
  VerificationContext validateIntegrity(
      Insertable<RelevantTaskStageData> instance,
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
    }
    if (data.containsKey('chain')) {
      context.handle(
          _chainMeta, chain.isAcceptableOrUnknown(data['chain']!, _chainMeta));
    } else if (isInserting) {
      context.missing(_chainMeta);
    }
    if (data.containsKey('campaign')) {
      context.handle(_campaignMeta,
          campaign.isAcceptableOrUnknown(data['campaign']!, _campaignMeta));
    } else if (isInserting) {
      context.missing(_campaignMeta);
    }
    if (data.containsKey('available_from')) {
      context.handle(
          _availableFromMeta,
          availableFrom.isAcceptableOrUnknown(
              data['available_from']!, _availableFromMeta));
    }
    if (data.containsKey('available_to')) {
      context.handle(
          _availableToMeta,
          availableTo.isAcceptableOrUnknown(
              data['available_to']!, _availableToMeta));
    }
    if (data.containsKey('stage_type')) {
      context.handle(_stageTypeMeta,
          stageType.isAcceptableOrUnknown(data['stage_type']!, _stageTypeMeta));
    }
    if (data.containsKey('open_limit')) {
      context.handle(_openLimitMeta,
          openLimit.isAcceptableOrUnknown(data['open_limit']!, _openLimitMeta));
    } else if (isInserting) {
      context.missing(_openLimitMeta);
    }
    if (data.containsKey('total_limit')) {
      context.handle(
          _totalLimitMeta,
          totalLimit.isAcceptableOrUnknown(
              data['total_limit']!, _totalLimitMeta));
    } else if (isInserting) {
      context.missing(_totalLimitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RelevantTaskStageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelevantTaskStageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      chain: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chain'])!,
      campaign: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}campaign'])!,
      availableFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}available_from']),
      availableTo: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}available_to']),
      stageType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stage_type']),
      openLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}open_limit'])!,
      totalLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_limit'])!,
    );
  }

  @override
  $RelevantTaskStageTable createAlias(String alias) {
    return $RelevantTaskStageTable(attachedDatabase, alias);
  }
}

class RelevantTaskStageData extends DataClass
    implements Insertable<RelevantTaskStageData> {
  final int id;
  final String name;
  final String? description;
  final int chain;
  final int campaign;
  final DateTime? availableFrom;
  final DateTime? availableTo;
  final String? stageType;
  final int openLimit;
  final int totalLimit;
  const RelevantTaskStageData(
      {required this.id,
      required this.name,
      this.description,
      required this.chain,
      required this.campaign,
      this.availableFrom,
      this.availableTo,
      this.stageType,
      required this.openLimit,
      required this.totalLimit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['chain'] = Variable<int>(chain);
    map['campaign'] = Variable<int>(campaign);
    if (!nullToAbsent || availableFrom != null) {
      map['available_from'] = Variable<DateTime>(availableFrom);
    }
    if (!nullToAbsent || availableTo != null) {
      map['available_to'] = Variable<DateTime>(availableTo);
    }
    if (!nullToAbsent || stageType != null) {
      map['stage_type'] = Variable<String>(stageType);
    }
    map['open_limit'] = Variable<int>(openLimit);
    map['total_limit'] = Variable<int>(totalLimit);
    return map;
  }

  RelevantTaskStageCompanion toCompanion(bool nullToAbsent) {
    return RelevantTaskStageCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      chain: Value(chain),
      campaign: Value(campaign),
      availableFrom: availableFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(availableFrom),
      availableTo: availableTo == null && nullToAbsent
          ? const Value.absent()
          : Value(availableTo),
      stageType: stageType == null && nullToAbsent
          ? const Value.absent()
          : Value(stageType),
      openLimit: Value(openLimit),
      totalLimit: Value(totalLimit),
    );
  }

  factory RelevantTaskStageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelevantTaskStageData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      chain: serializer.fromJson<int>(json['chain']),
      campaign: serializer.fromJson<int>(json['campaign']),
      availableFrom: serializer.fromJson<DateTime?>(json['availableFrom']),
      availableTo: serializer.fromJson<DateTime?>(json['availableTo']),
      stageType: serializer.fromJson<String?>(json['stageType']),
      openLimit: serializer.fromJson<int>(json['openLimit']),
      totalLimit: serializer.fromJson<int>(json['totalLimit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'chain': serializer.toJson<int>(chain),
      'campaign': serializer.toJson<int>(campaign),
      'availableFrom': serializer.toJson<DateTime?>(availableFrom),
      'availableTo': serializer.toJson<DateTime?>(availableTo),
      'stageType': serializer.toJson<String?>(stageType),
      'openLimit': serializer.toJson<int>(openLimit),
      'totalLimit': serializer.toJson<int>(totalLimit),
    };
  }

  RelevantTaskStageData copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          int? chain,
          int? campaign,
          Value<DateTime?> availableFrom = const Value.absent(),
          Value<DateTime?> availableTo = const Value.absent(),
          Value<String?> stageType = const Value.absent(),
          int? openLimit,
          int? totalLimit}) =>
      RelevantTaskStageData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        chain: chain ?? this.chain,
        campaign: campaign ?? this.campaign,
        availableFrom:
            availableFrom.present ? availableFrom.value : this.availableFrom,
        availableTo: availableTo.present ? availableTo.value : this.availableTo,
        stageType: stageType.present ? stageType.value : this.stageType,
        openLimit: openLimit ?? this.openLimit,
        totalLimit: totalLimit ?? this.totalLimit,
      );
  @override
  String toString() {
    return (StringBuffer('RelevantTaskStageData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('chain: $chain, ')
          ..write('campaign: $campaign, ')
          ..write('availableFrom: $availableFrom, ')
          ..write('availableTo: $availableTo, ')
          ..write('stageType: $stageType, ')
          ..write('openLimit: $openLimit, ')
          ..write('totalLimit: $totalLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, chain, campaign,
      availableFrom, availableTo, stageType, openLimit, totalLimit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelevantTaskStageData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.chain == this.chain &&
          other.campaign == this.campaign &&
          other.availableFrom == this.availableFrom &&
          other.availableTo == this.availableTo &&
          other.stageType == this.stageType &&
          other.openLimit == this.openLimit &&
          other.totalLimit == this.totalLimit);
}

class RelevantTaskStageCompanion
    extends UpdateCompanion<RelevantTaskStageData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> chain;
  final Value<int> campaign;
  final Value<DateTime?> availableFrom;
  final Value<DateTime?> availableTo;
  final Value<String?> stageType;
  final Value<int> openLimit;
  final Value<int> totalLimit;
  const RelevantTaskStageCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.chain = const Value.absent(),
    this.campaign = const Value.absent(),
    this.availableFrom = const Value.absent(),
    this.availableTo = const Value.absent(),
    this.stageType = const Value.absent(),
    this.openLimit = const Value.absent(),
    this.totalLimit = const Value.absent(),
  });
  RelevantTaskStageCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required int chain,
    required int campaign,
    this.availableFrom = const Value.absent(),
    this.availableTo = const Value.absent(),
    this.stageType = const Value.absent(),
    required int openLimit,
    required int totalLimit,
  })  : name = Value(name),
        chain = Value(chain),
        campaign = Value(campaign),
        openLimit = Value(openLimit),
        totalLimit = Value(totalLimit);
  static Insertable<RelevantTaskStageData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? chain,
    Expression<int>? campaign,
    Expression<DateTime>? availableFrom,
    Expression<DateTime>? availableTo,
    Expression<String>? stageType,
    Expression<int>? openLimit,
    Expression<int>? totalLimit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (chain != null) 'chain': chain,
      if (campaign != null) 'campaign': campaign,
      if (availableFrom != null) 'available_from': availableFrom,
      if (availableTo != null) 'available_to': availableTo,
      if (stageType != null) 'stage_type': stageType,
      if (openLimit != null) 'open_limit': openLimit,
      if (totalLimit != null) 'total_limit': totalLimit,
    });
  }

  RelevantTaskStageCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<int>? chain,
      Value<int>? campaign,
      Value<DateTime?>? availableFrom,
      Value<DateTime?>? availableTo,
      Value<String?>? stageType,
      Value<int>? openLimit,
      Value<int>? totalLimit}) {
    return RelevantTaskStageCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      chain: chain ?? this.chain,
      campaign: campaign ?? this.campaign,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
      stageType: stageType ?? this.stageType,
      openLimit: openLimit ?? this.openLimit,
      totalLimit: totalLimit ?? this.totalLimit,
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
    if (chain.present) {
      map['chain'] = Variable<int>(chain.value);
    }
    if (campaign.present) {
      map['campaign'] = Variable<int>(campaign.value);
    }
    if (availableFrom.present) {
      map['available_from'] = Variable<DateTime>(availableFrom.value);
    }
    if (availableTo.present) {
      map['available_to'] = Variable<DateTime>(availableTo.value);
    }
    if (stageType.present) {
      map['stage_type'] = Variable<String>(stageType.value);
    }
    if (openLimit.present) {
      map['open_limit'] = Variable<int>(openLimit.value);
    }
    if (totalLimit.present) {
      map['total_limit'] = Variable<int>(totalLimit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelevantTaskStageCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('chain: $chain, ')
          ..write('campaign: $campaign, ')
          ..write('availableFrom: $availableFrom, ')
          ..write('availableTo: $availableTo, ')
          ..write('stageType: $stageType, ')
          ..write('openLimit: $openLimit, ')
          ..write('totalLimit: $totalLimit')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $CampaignTable campaign = $CampaignTable(this);
  late final $TaskStageTable taskStage = $TaskStageTable(this);
  late final $TaskTable task = $TaskTable(this);
  late final $RelevantTaskStageTable relevantTaskStage =
      $RelevantTaskStageTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [campaign, taskStage, task, relevantTaskStage];
}
