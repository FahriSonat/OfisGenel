enum SupportRole {
  mentor('Mentor'),
  accountant('Muhasebe'),
  lawyer('Avukat'),
  investor('Yatırımcı'),
  marketing('Pazarlama Uzmanı');

  const SupportRole(this.label);
  final String label;

  static SupportRole? tryParse(String slug) {
    for (final r in SupportRole.values) {
      if (r.name == slug) return r;
    }
    return null;
  }
}
