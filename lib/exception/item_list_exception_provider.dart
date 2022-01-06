import 'package:fire_riverpod_playground/exception/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// エラー表示領域を制限
final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);