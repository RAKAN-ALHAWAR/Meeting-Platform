enum AttendanceStatusStatusX {
  present(1),
  absent(2),
  excused(3),
  byDelegated(4);

  final int status;
  const AttendanceStatusStatusX(this.status);
}
