import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:meeting/Ui/Screen/Delegate/AllDelegates/view/view.dart';
import '../../Ui/Screen/Home/view/view.dart';
import '../../Ui/Screen/Meeting/AllMeetings/view/view.dart';
import '../../Ui/Screen/Profile/ProfileDetails/view/view.dart';
import '../Model/basic/root_page.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Control data of nav bar elements
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
List<RootPageX> navBarItems = [
  RootPageX(
    view: const HomeView(),
    label: 'Home',
    icon: const Icon(Iconsax.home),
  ),
  RootPageX(
    view: const AllMeetingsView(),
    label: 'Meetings',
    icon: const Icon(Iconsax.people),
  ),
  RootPageX(
    view: const AllDelegatesView(),
    label: 'Delegations',
    icon: const Icon(Iconsax.document_text),
  ),
  RootPageX(
    view: const ProfileDetailsView(),
    label: 'Profile',
    icon: const Icon(IconsaxPlusLinear.profile),
  )
];