import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_exception.dart';

// エラー表示領域を制限
final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);