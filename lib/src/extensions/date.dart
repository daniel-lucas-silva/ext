import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toYYYYMMDD() => this.toString().split(" ")[0];

  String toDDMMYYYY() => DateFormat.yMd('pt_BR').format(this);

  String format([String pattern]) =>
      DateFormat(pattern ?? 'dd/MM/yyyy  HH:mm:ss', 'pt_BR').format(this);
}