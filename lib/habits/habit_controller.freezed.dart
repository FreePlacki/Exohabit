// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitEditState {

 bool get isSaving; String? get error;
/// Create a copy of HabitEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitEditStateCopyWith<HabitEditState> get copyWith => _$HabitEditStateCopyWithImpl<HabitEditState>(this as HabitEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitEditState&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isSaving,error);

@override
String toString() {
  return 'HabitEditState(isSaving: $isSaving, error: $error)';
}


}

/// @nodoc
abstract mixin class $HabitEditStateCopyWith<$Res>  {
  factory $HabitEditStateCopyWith(HabitEditState value, $Res Function(HabitEditState) _then) = _$HabitEditStateCopyWithImpl;
@useResult
$Res call({
 bool isSaving, String? error
});




}
/// @nodoc
class _$HabitEditStateCopyWithImpl<$Res>
    implements $HabitEditStateCopyWith<$Res> {
  _$HabitEditStateCopyWithImpl(this._self, this._then);

  final HabitEditState _self;
  final $Res Function(HabitEditState) _then;

/// Create a copy of HabitEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSaving = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HabitEditState].
extension HabitEditStatePatterns on HabitEditState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitEditState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitEditState value)  $default,){
final _that = this;
switch (_that) {
case _HabitEditState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitEditState value)?  $default,){
final _that = this;
switch (_that) {
case _HabitEditState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSaving,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitEditState() when $default != null:
return $default(_that.isSaving,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSaving,  String? error)  $default,) {final _that = this;
switch (_that) {
case _HabitEditState():
return $default(_that.isSaving,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSaving,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _HabitEditState() when $default != null:
return $default(_that.isSaving,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _HabitEditState implements HabitEditState {
  const _HabitEditState({required this.isSaving, this.error});
  

@override final  bool isSaving;
@override final  String? error;

/// Create a copy of HabitEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitEditStateCopyWith<_HabitEditState> get copyWith => __$HabitEditStateCopyWithImpl<_HabitEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitEditState&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isSaving,error);

@override
String toString() {
  return 'HabitEditState(isSaving: $isSaving, error: $error)';
}


}

/// @nodoc
abstract mixin class _$HabitEditStateCopyWith<$Res> implements $HabitEditStateCopyWith<$Res> {
  factory _$HabitEditStateCopyWith(_HabitEditState value, $Res Function(_HabitEditState) _then) = __$HabitEditStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSaving, String? error
});




}
/// @nodoc
class __$HabitEditStateCopyWithImpl<$Res>
    implements _$HabitEditStateCopyWith<$Res> {
  __$HabitEditStateCopyWithImpl(this._self, this._then);

  final _HabitEditState _self;
  final $Res Function(_HabitEditState) _then;

/// Create a copy of HabitEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSaving = null,Object? error = freezed,}) {
  return _then(_HabitEditState(
isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
