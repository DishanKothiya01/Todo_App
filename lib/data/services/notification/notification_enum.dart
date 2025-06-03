
///* INCOMING NOTIFICATION TYPES
enum NotificationType {
  /// ***********************************************************************************
  /// *                                FROM USERS SELF                                  *
  /// ***********************************************************************************
  reminder(label: 'Reminder', slug: 'reminder'),

  /// ***********************************************************************************
  /// *                                FROM ADMIN TYPES                                 *
  /// ***********************************************************************************
  homeScreen(label: 'Home Screen', slug: 'home_screen'),
  petDiary(label: 'Pet Diary', slug: 'pet_diary'),
  parentProfile(label: 'Parent Profile', slug: 'parent_profile'),
  remindersSection(label: 'Reminders Section', slug: 'reminders_section'),
  walkingSection(label: 'Walking Section', slug: 'walking_section'),
  currentlyWalking(label: 'Currently Walking', slug: 'currently_walking'), //? It's local notification type not API (backend)

  mealsSection(label: 'Meals Section', slug: 'meals_section'),
  expenseSection(label: 'Expense Section', slug: 'expense_section'),
  addPet(label: 'Add Pet', slug: 'add_pet'),
  petDetails(label: 'Pet Details', slug: 'pet_details'), //! Pet id is required

  editPetProfile(label: 'Edit Pet Profile', slug: 'edit_pet_profile'), //! Pet id is required

  petShorts(label: 'Pet Shorts', slug: 'pet_sort'),
  petStore(label: 'Pet Store', slug: 'pet_store_view'),
  petGroomer(label: 'Pet Groomer', slug: 'pet_groomer_view'),
  petWalkers(label: 'Pet Walkers', slug: 'pet_walkers_view'),
  petBoarders(label: 'Pet Boarders', slug: 'pet_stays_view'),
  petTraining(label: 'Pet Training', slug: 'pet_training_view'),
  petSitters(label: 'Pet Sitters', slug: 'pet_sitters_view'),
  petParks(label: 'Pet Parks', slug: 'pet_parks_view'),
  petVets(label: 'Pet Vets', slug: 'pet_veterinary_view'),
  allExploreService(label: 'All Explore Service', slug: 'explore_all_services'),
  pausePetWalking(label: 'Pause Pet Walking', slug: 'pause_pet_walking'),

  /// ***********************************************************************************
  /// *                        FROM OTHER USERS OR PET PARENTS                          *
  /// ***********************************************************************************
  connectExplore(label: 'Connect Explore', slug: 'connect_explore'),
  connectMessages(label: 'Connect Messages', slug: 'connect_messages'),
  connectRequests(label: 'Connect Requests', slug: 'connect_requests'),
  acceptRequest(label: 'Accept Request', slug: 'accept_request'),
  petInvitation(label: 'Pet Invitation', slug: 'pet_invitation'),
  joinPetFamily(label: 'Join Pet Family', slug: 'join_pet_family'),
  sharedPetRemoved(label: 'Pet Invitation', slug: 'shared_pet_removed');

  final String label;
  final String slug;

  const NotificationType({
    required this.label,
    required this.slug,
  });

  static NotificationType fromSlug(String slug) {
    return NotificationType.values.firstWhere((e) => e.slug == slug);
  }

  static bool isValidSlug(String slug) {
    return NotificationType.values.any((e) => e.slug == slug);
  }
}
