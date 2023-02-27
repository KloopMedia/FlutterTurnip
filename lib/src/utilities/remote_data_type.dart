import 'package:equatable/equatable.dart';

mixin RemoteDataFetching on RemoteDataType {}

mixin RemoteDataSuccess on RemoteDataType {}

mixin RemoteDataError on RemoteDataType {}

abstract class RemoteDataType extends Equatable {}
