// routes.dart

import 'package:flutter/material.dart';
import 'package:flutter_driver/res/custom_rideIssue_page.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/cardPage.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/changePassword.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/contact.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/faqPage.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/help&support.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/notification.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/profilePage.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/raiseIssueDetails.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/term_condition.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/transaction.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/verifyPassword.dart';
import 'package:flutter_driver/view/dashboard/home_screen.dart';
import 'package:flutter_driver/view/dashboard/menuList.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/editProfile.dart';
import 'package:flutter_driver/view/dashboard/package/packageBookingList.dart';
import 'package:flutter_driver/view/dashboard/package/packageDetailPage.dart';
import 'package:flutter_driver/view/dashboard/package/package_management_screen.dart';
import 'package:flutter_driver/view/dashboard/package/pageViewDetails.dart';
import 'package:flutter_driver/view/dashboard/raiseIssue_pages/issueViewDetails.dart';
import 'package:flutter_driver/view/dashboard/rental/bookingPage.dart';
import 'package:flutter_driver/view/dashboard/rental/detailsOfBookings.dart';
import 'package:flutter_driver/view/dashboard/rental/history/rentalHistoryManagment.dart';
import 'package:flutter_driver/view/dashboard/rental/onRunning_DetailsPage.dart';
import 'package:flutter_driver/view/registration/forgot_screen.dart';
import 'package:flutter_driver/view/registration/login_screen.dart';
import 'package:flutter_driver/view/registration/otp_verification_screen.dart';
import 'package:flutter_driver/view/registration/reset_password_screen.dart';
import 'package:flutter_driver/view/registration/splash_screen.dart';
import 'package:go_router/go_router.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter myRouter = GoRouter(
  // initialLocation: '/profilePage/editProfilePage',
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    ///For Bottom Navigation Regarding
    // ShellRoute(
    //   navigatorKey: _shellNavigatorKey,
    //   builder: (BuildContext context, GoRouterState state, Widget child) {
    //     return CustomBottomNavigationBar(
    //         child: child, currentRoute: state.uri.toString());
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       parentNavigatorKey: _shellNavigatorKey,
    //       pageBuilder: (context, state) {
    //         return const NoTransitionPage(child:
    //         VendorProfileScreen()
    //         );
    //       },
    //     ),
    //     GoRoute(
    //         path: '/vendor',
    //         parentNavigatorKey: _shellNavigatorKey,
    //         pageBuilder: (context, state) {
    //           return const NoTransitionPage(child: VendorProfileScreen());
    //         },
    //         routes: [
    //           GoRoute(
    //             path: 'vendor',
    //             parentNavigatorKey: _rootNavigatorKey,
    //             pageBuilder: (context, state) {
    //               return const NoTransitionPage(child: VendorProfileScreen());
    //             },
    //           ),
    //           GoRoute(
    //             path: 'vendor',
    //             parentNavigatorKey: _rootNavigatorKey,
    //             pageBuilder: (context, state) {
    //               final title = state.extra as Map<String, dynamic>;
    //               final color = state.extra as Map<String, dynamic>;
    //               return NoTransitionPage(
    //                   child:VendorProfileScreen());
    //             },
    //           ),
    //         ]),
    //     GoRoute(
    //         path: '/vendor',
    //         parentNavigatorKey: _shellNavigatorKey,
    //         pageBuilder: (context, state) {
    //           return const NoTransitionPage(child: VendorProfileScreen());
    //         },
    //         routes: []),
    //     GoRoute(
    //       path: '/vendor',
    //       parentNavigatorKey: _shellNavigatorKey,
    //       pageBuilder: (context, state) {
    //         return const NoTransitionPage(child: VendorProfileScreen());
    //       },
    //     ),
    //   ],
    // ),
    GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashSreen();
        }),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),

    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        // var zoneId = state.extra as Map<String, dynamic>;
        return const home_screen(
            // timeZone: zoneId['zoneId'],
            );
      },
    ),
    GoRoute(
      path: '/homePageBookingList',
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return BookingDetailsPage(
          userId: data['userID'],
        );
      },
    ),
    GoRoute(
      path: '/notification',
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationPage();
      },
    ),
    //
    GoRoute(
      path: '/menuPage',
      pageBuilder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return CustomTransitionPage(
          key: state.pageKey,
          child: MenuList(userId: data['id']),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
        path: '/profilePage',
        builder: (BuildContext context, GoRouterState state) {
          var data = state.extra as Map<String, dynamic>;
          return ProfilePage(
            user: data['userId'],
          );
        },
        routes: [
          GoRoute(
            path: 'editProfilePage',
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              var phone = state.extra as Map<String, dynamic>;
              return EditProfiePage(
                usrId: data['uId'],
                mobileNumber: phone['phoneNo'],
              );
            },
          ),
        ]),
    GoRoute(
      path: '/historyManagement',
      pageBuilder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
            child: DriverHistoryManagment(
          myID: data["myID"],
        ));
      },
    ),
    GoRoute(
      path: '/packageBookingList',
      pageBuilder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
            child: PackageBookingList(
          myId: data['myId'],
          historylist: data['historyList'],
        ));
      },
    ),
    GoRoute(
      path: '/pageViewDetails',
      pageBuilder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return NoTransitionPage(
            child: PageViewDetails(
          driverAss: data['driverAss'],
        ));
      },
    ),
    GoRoute(
      path: '/packageBookingManagement',
      // parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const PackageManagementScreen();
      },
    ),
    GoRoute(
      path: '/packageDetailPage',
      // parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var bookingId = state.extra as Map<String, dynamic>;
        var driverId = state.extra as Map<String, dynamic>;
        return Packagedetailpage(
          bookingId: bookingId["bookingId"],
          driverId: driverId["driverId"],
        );
      },
    ),
    GoRoute(
      path: '/setting',
      pageBuilder: (BuildContext context, GoRouterState state) {
        // var data = state.extra as Map<String, dynamic>;
        return const NoTransitionPage(
            child: Scaffold(
          body: Center(child: Text("Setting Page")),
        ));
      },
    ),
    GoRoute(
      path: '/changePassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const ChangePassword();
      },
    ),
    GoRoute(
      path: '/verifyPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const VerifyPassword();
      },
    ),

    GoRoute(
      path: '/forgotPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPassword();
      },
    ),
    GoRoute(
      path: '/verifyOtp',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return OtpVerificationScreen(
          email: data["email"],
        );
      },
    ),
    GoRoute(
      path: '/resetPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;

        return ResetPasswordScreen(
          email: data["email"],
        );
      },
    ),
    GoRoute(
      path: '/faqPage',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const FAQPage();
      },
    ),
    GoRoute(
      path: '/termCondition',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const TermCondition();
      },
    ),
    GoRoute(
      path: '/contact',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const ContactPage();
      },
    ),
    GoRoute(
      path: '/help&support',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpAndSupport();
      },
    ),
    GoRoute(
      path: '/rideIssue',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var dataValue = state.extra as Map<String, dynamic>;
        return CustomRideissuePage(
          bookingId: dataValue['bookingId'],
          bookingType: dataValue['bookingType'],
        );
      },
    ),
    GoRoute(
      path: '/getRaiseIssue',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const Raiseissuedetails();
      },
    ),
    GoRoute(
      path: '/issueDetailsbyId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const Issueviewdetails();
      },
    ),
    GoRoute(
      path: '/myCards',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const CardPage();
      },
    ),
    GoRoute(
      path: '/myTransaction',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const MyTransaction();
      },
    ),
    // GoRoute(
    //   path: '/bookingDetails',
    //   parentNavigatorKey: _rootNavigatorKey,
    //   builder: (BuildContext context, GoRouterState state) {
    //     print('state.extra: ${state.extra}'); // Debug print
    //
    //     if (state.extra == null || state.extra is! Map<String, dynamic>) {
    //       return Scaffold(body: Center(child: Text("ERROR"),),); // Replace with an appropriate error handling widget
    //     }
    //
    //     var data = state.extra as Map<String, dynamic>;
    //
    //     return BookingDetailsOfDriver(
    //       bookingId: data['bookId'],
    //       driverId: data['myDriverId'],
    //     );
    //   },
    // ),
    GoRoute(
      path: '/bookingDetails',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        var id = state.extra as Map<String, dynamic>;
        return BookingDetailsOfDriver(
          bookingId: data['bookId'],
          driverId: id['myDriverId'],
        );
      },
    ),
    GoRoute(
      path: '/onRunning_DetailsPage',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var bookingID = state.extra as Map<String, dynamic>;
        var dID = state.extra as Map<String, dynamic>;
        return OnRunning_DetailsPage(
          bookingId: bookingID['bookId'],
          dvrID: dID['driverID'],
        );
      },
    ),
    //       GoRoute(
    //           path: 'selectItem',
    //           parentNavigatorKey: _rootNavigatorKey,
    //           pageBuilder: (context, state) {
    //             var data = state.extra as Map<String, dynamic>;
    //             return NoTransitionPage(
    //                 child: SelectItem(
    //               selectedItems: data["notifier"],
    //               customer: data["customer"],
    //             ));
    //           }),
  ],
);
//
// extension GoRouterEx on GoRouter {
//   void popUntilPath(BuildContext context, String routePath) {
//     final router = GoRouterState.of(context);
//     while (router.uri.toString() != routePath) {
//       if (!router.canPop()) {
//         return;
//       }
//       debugPrint('Popping ${router.location}');
//       router.pop();
//     }
//   }
// }
