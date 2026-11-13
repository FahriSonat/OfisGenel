import 'package:flutter/material.dart';
import '../../features/support_space/domain/entities/support_role.dart';
import 'app_colors.dart';

extension SupportRoleStyle on SupportRole {
  Color get accent => switch (this) {
        SupportRole.mentor => AppColors.mentor,
        SupportRole.accountant => AppColors.accountant,
        SupportRole.lawyer => AppColors.lawyer,
        SupportRole.investor => AppColors.investor,
        SupportRole.marketing => AppColors.marketing,
      };

  IconData get icon => switch (this) {
        SupportRole.mentor => Icons.school_outlined,
        SupportRole.accountant => Icons.calculate_outlined,
        SupportRole.lawyer => Icons.gavel_outlined,
        SupportRole.investor => Icons.trending_up,
        SupportRole.marketing => Icons.campaign_outlined,
      };

  String get shortDescription => switch (this) {
        SupportRole.mentor =>
          'Girişiminizi büyütmek için deneyimli rehberlerle strateji geliştirin.',
        SupportRole.accountant =>
          'Mali süreçlerinizi, bütçenizi ve vergi planlamanızı optimize edin.',
        SupportRole.lawyer =>
          'Sözleşmelerinizi, şirketleşme ve KVKK süreçlerinizi güvenceye alın.',
        SupportRole.investor =>
          'Yatırım turlarına hazırlanın, fonlama ve değerleme stratejileri kurun.',
        SupportRole.marketing =>
          'Büyüme (growth), marka iletişimi ve pazar kazanım taktiklerinizi güçlendirin.',
      };
}
