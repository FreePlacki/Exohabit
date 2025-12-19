// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitCompletion {

 String get id; String get habitId; String get userId; DateTime get completedAt; String? get exoplanetId;
/// Create a copy of HabitCompletion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitCompletionCopyWith<HabitCompletion> get copyWith => _$HabitCompletionCopyWithImpl<HabitCompletion>(this as HabitCompletion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitCompletion&&(identical(other.id, id) || other.id == id)&&(identical(other.habitId, habitId) || other.habitId == habitId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.exoplanetId, exoplanetId) || other.exoplanetId == exoplanetId));
}


@override
int get hashCode => Object.hash(runtimeType,id,habitId,userId,completedAt,exoplanetId);

@override
String toString() {
  return 'HabitCompletion(id: $id, habitId: $habitId, userId: $userId, completedAt: $completedAt, exoplanetId: $exoplanetId)';
}


}

/// @nodoc
abstract mixin class $HabitCompletionCopyWith<$Res>  {
  factory $HabitCompletionCopyWith(HabitCompletion value, $Res Function(HabitCompletion) _then) = _$HabitCompletionCopyWithImpl;
@useResult
$Res call({
 String id, String habitId, String userId, DateTime completedAt, String? exoplanetId
});




}
/// @nodoc
class _$HabitCompletionCopyWithImpl<$Res>
    implements $HabitCompletionCopyWith<$Res> {
  _$HabitCompletionCopyWithImpl(this._self, this._then);

  final HabitCompletion _self;
  final $Res Function(HabitCompletion) _then;

/// Create a copy of HabitCompletion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? habitId = null,Object? userId = null,Object? completedAt = null,Object? exoplanetId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,habitId: null == habitId ? _self.habitId : habitId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,exoplanetId: freezed == exoplanetId ? _self.exoplanetId : exoplanetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HabitCompletion].
extension HabitCompletionPatterns on HabitCompletion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitCompletion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitCompletion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitCompletion value)  $default,){
final _that = this;
switch (_that) {
case _HabitCompletion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitCompletion value)?  $default,){
final _that = this;
switch (_that) {
case _HabitCompletion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String habitId,  String userId,  DateTime completedAt,  String? exoplanetId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitCompletion() when $default != null:
return $default(_that.id,_that.habitId,_that.userId,_that.completedAt,_that.exoplanetId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String habitId,  String userId,  DateTime completedAt,  String? exoplanetId)  $default,) {final _that = this;
switch (_that) {
case _HabitCompletion():
return $default(_that.id,_that.habitId,_that.userId,_that.completedAt,_that.exoplanetId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String habitId,  String userId,  DateTime completedAt,  String? exoplanetId)?  $default,) {final _that = this;
switch (_that) {
case _HabitCompletion() when $default != null:
return $default(_that.id,_that.habitId,_that.userId,_that.completedAt,_that.exoplanetId);case _:
  return null;

}
}

}

/// @nodoc


class _HabitCompletion implements HabitCompletion {
  const _HabitCompletion({required this.id, required this.habitId, required this.userId, required this.completedAt, this.exoplanetId});
  

@override final  String id;
@override final  String habitId;
@override final  String userId;
@override final  DateTime completedAt;
@override final  String? exoplanetId;

/// Create a copy of HabitCompletion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitCompletionCopyWith<_HabitCompletion> get copyWith => __$HabitCompletionCopyWithImpl<_HabitCompletion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitCompletion&&(identical(other.id, id) || other.id == id)&&(identical(other.habitId, habitId) || other.habitId == habitId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.exoplanetId, exoplanetId) || other.exoplanetId == exoplanetId));
}


@override
int get hashCode => Object.hash(runtimeType,id,habitId,userId,completedAt,exoplanetId);

@override
String toString() {
  return 'HabitCompletion(id: $id, habitId: $habitId, userId: $userId, completedAt: $completedAt, exoplanetId: $exoplanetId)';
}


}

/// @nodoc
abstract mixin class _$HabitCompletionCopyWith<$Res> implements $HabitCompletionCopyWith<$Res> {
  factory _$HabitCompletionCopyWith(_HabitCompletion value, $Res Function(_HabitCompletion) _then) = __$HabitCompletionCopyWithImpl;
@override @useResult
$Res call({
 String id, String habitId, String userId, DateTime completedAt, String? exoplanetId
});




}
/// @nodoc
class __$HabitCompletionCopyWithImpl<$Res>
    implements _$HabitCompletionCopyWith<$Res> {
  __$HabitCompletionCopyWithImpl(this._self, this._then);

  final _HabitCompletion _self;
  final $Res Function(_HabitCompletion) _then;

/// Create a copy of HabitCompletion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? habitId = null,Object? userId = null,Object? completedAt = null,Object? exoplanetId = freezed,}) {
  return _then(_HabitCompletion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,habitId: null == habitId ? _self.habitId : habitId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,exoplanetId: freezed == exoplanetId ? _self.exoplanetId : exoplanetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
