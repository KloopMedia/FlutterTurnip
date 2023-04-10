// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'webhook_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookResponse _$WebhookResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'WebhookResponse',
      json,
      ($checkedConvert) {
        final val = WebhookResponse(
          status: $checkedConvert('status', (v) => v as String),
          responses:
              $checkedConvert('responses', (v) => v as Map<String, dynamic>),
        );
        return val;
      },
    );
