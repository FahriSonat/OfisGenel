import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/ai_chat/presentation/screens/ai_chat_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/files/presentation/screens/files_screen.dart';
import '../../features/meetings/presentation/screens/meetings_screen.dart';
import '../../features/programs/presentation/screens/program_01_screen.dart';
import '../../features/programs/presentation/screens/program_02_screen.dart';
import '../../features/programs/presentation/screens/program_03_screen.dart';
import '../../features/programs/presentation/screens/program_04_screen.dart';
import '../../features/programs/presentation/screens/program_05_screen.dart';
import '../../features/programs/presentation/screens/program_06_screen.dart';
import '../../features/programs/presentation/screens/program_07_screen.dart';
import '../../features/programs/presentation/widgets/program_scaffold.dart';
import '../../features/startups/presentation/screens/investor_startups_screen.dart';
import '../../features/startups/presentation/screens/startups_screen.dart';
import '../../features/support_booking/domain/entities/service_type.dart';
import '../../features/support_booking/presentation/screens/support_booking_screen.dart';
import '../../features/support_space/domain/entities/support_role.dart';
import '../../features/support_space/presentation/screens/accountant_space_screen.dart';
import '../../features/support_space/presentation/screens/investor_space_screen.dart';
import '../../features/support_space/presentation/screens/lawyer_space_screen.dart';
import '../../features/support_space/presentation/screens/marketing_space_screen.dart';
import '../../features/support_space/presentation/screens/mentor_space_screen.dart';
import '../../shared/widgets/app_shell.dart';
import 'routes.dart';

Widget _buildRoleScreen(SupportRole role) {
  return switch (role) {
    SupportRole.mentor => const MentorSpaceScreen(),
    SupportRole.accountant => const AccountantSpaceScreen(),
    SupportRole.lawyer => const LawyerSpaceScreen(),
    SupportRole.investor => const InvestorSpaceScreen(),
    SupportRole.marketing => const MarketingSpaceScreen(),
  };
}

Widget _buildProgramScreen(String slug) {
  return switch (slug) {
    'program-1' => const Program01Screen(),
    'program-2' => const Program02Screen(),
    'program-3' => const Program03Screen(),
    'program-4' => const Program04Screen(),
    'program-5' => const Program05Screen(),
    'program-6' => const Program06Screen(),
    'program-7' => const Program07Screen(),
    _ => ProgramScaffold(slug: slug),
  };
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.initialRoute,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            location: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          // 1. Role Space Screen
          GoRoute(
            path: AppRoutes.spaceRole,
            redirect: (context, state) {
              final roleParam = state.pathParameters['role'];
              if (roleParam == null ||
                  SupportRole.tryParse(roleParam) == null) {
                return AppRoutes.initialRoute;
              }
              return null;
            },
            builder: (context, state) {
              final roleParam = state.pathParameters['role']!;
              final role = SupportRole.tryParse(roleParam)!;
              return _buildRoleScreen(role);
            },
          ),

          // 2. AI Chat
          GoRoute(
            path: AppRoutes.aiChat,
            redirect: (context, state) {
              final roleParam = state.pathParameters['role'];
              if (roleParam == null ||
                  SupportRole.tryParse(roleParam) == null) {
                return AppRoutes.initialRoute;
              }
              return null;
            },
            builder: (context, state) {
              final roleParam = state.pathParameters['role']!;
              return AiChatScreen(roleSlug: roleParam);
            },
          ),

          // 3. Files
          GoRoute(
            path: AppRoutes.files,
            redirect: (context, state) {
              final roleParam = state.pathParameters['role'];
              if (roleParam == null ||
                  SupportRole.tryParse(roleParam) == null) {
                return AppRoutes.initialRoute;
              }
              return null;
            },
            builder: (context, state) {
              final roleParam = state.pathParameters['role']!;
              return FilesScreen(roleSlug: roleParam);
            },
          ),

          // 4. Chat
          GoRoute(
            path: AppRoutes.chat,
            redirect: (context, state) {
              final roleParam = state.pathParameters['role'];
              if (roleParam == null ||
                  SupportRole.tryParse(roleParam) == null) {
                return AppRoutes.initialRoute;
              }
              return null;
            },
            builder: (context, state) {
              final roleParam = state.pathParameters['role']!;
              return ChatScreen(roleSlug: roleParam);
            },
          ),

          // 5. Meetings
          GoRoute(
            path: AppRoutes.meetings,
            redirect: (context, state) {
              final roleParam = state.pathParameters['role'];
              if (roleParam == null ||
                  SupportRole.tryParse(roleParam) == null) {
                return AppRoutes.initialRoute;
              }
              return null;
            },
            builder: (context, state) {
              final roleParam = state.pathParameters['role']!;
              return MeetingsScreen(roleSlug: roleParam);
            },
          ),

          // 6. Support Booking
          GoRoute(
            path: AppRoutes.booking,
            redirect: (context, state) {
              final roleParam = state.pathParameters['role'];
              final serviceParam = state.pathParameters['serviceType'];
              if (roleParam == null ||
                  SupportRole.tryParse(roleParam) == null) {
                return AppRoutes.initialRoute;
              }
              if (serviceParam == null ||
                  ServiceType.tryParse(serviceParam) == null) {
                return AppRoutes.bookingPath(roleParam, 'mentor');
              }
              return null;
            },
            builder: (context, state) {
              final roleParam = state.pathParameters['role']!;
              final serviceParam = state.pathParameters['serviceType']!;
              return SupportBookingScreen(
                roleSlug: roleParam,
                initialServiceType: serviceParam,
              );
            },
          ),

          // 7. Programs Detail
          GoRoute(
            path: AppRoutes.programDetail,
            builder: (context, state) {
              final slug = state.pathParameters['slug'] ?? 'program-1';
              return _buildProgramScreen(slug);
            },
          ),

          // 8. Girişim Projeleri Sayfası
          GoRoute(
            path: AppRoutes.startups,
            builder: (context, state) {
              return const StartupsScreen();
            },
          ),

          // 9. Yatırımcı Girişim Keşif Sayfası
          GoRoute(
            path: AppRoutes.investorStartups,
            builder: (context, state) {
              return const InvestorStartupsScreen();
            },
          ),
        ],
      ),
    ],
  );
});
