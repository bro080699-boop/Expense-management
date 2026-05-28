# Daily Expense Tracker App

### 🎥 Demo Video

https://github.com/user-attachments/assets/6c1acffc-b375-47c2-857d-d4cd2ffbb8d5


---

### 📸 Screenshots

<p align="left">
  <img width="200" alt="WhatsApp Image 2026-05-28 at 12 45 30 PM" src="https://github.com/user-attachments/assets/0a5319bd-eb6b-4bbf-bef6-983446cebfdd" />
  <img width="200" alt="WhatsApp Image 2026-05-28 at 12 45 33 PM" src="https://github.com/user-attachments/assets/45d8dfd0-6fc8-4cec-a641-d982814fffcb" />
<img width="200" alt="WhatsApp Image 2026-05-28 at 12 45 32 PM (1)" src="https://github.com/user-attachments/assets/6085ad15-1912-4a26-a22a-00832e572bf0" />
<img width="200" alt="WhatsApp Image 2026-05-28 at 12 45 31 PM" src="https://github.com/user-attachments/assets/77efdec3-0dd6-49c8-9e86-331011d84d38" />
<img width="200" alt="WhatsApp Image 2026-05-28 at 12 45 30 PM (1)" src="https://github.com/user-attachments/assets/e0cca003-166d-430f-86b1-3c2a48a2f642" />
</p>

---

## Project Overview

Daily Expense Tracker is a simple Flutter app for managing daily expenses.

The user can add expenses, see expense list, edit old expenses, delete expenses, search expenses, filter by category, and view a small analytics summary.

The app stores data locally, so expenses remain saved even after closing and reopening the app.

## Main Features

- Add expense
- Edit expense
- Delete expense
- Search expense
- Filter by category
- Category-wise analytics
- Total expense summary
- Light mode and dark mode
- Local storage
- Form validation
- Smooth screen transition
- Responsive UI

## Tech Stack

- Flutter
- Dart
- GetX
- SharedPreferences
- Material Design

## Packages Used

```yaml
get: ^4.7.3
shared_preferences: ^2.5.5
```

## Project Structure

```text
lib/
  main.dart

  controllers/
    expense_controller.dart
    theme_controller.dart

  models/
    expense_model.dart

  services/
    expense_service.dart

  utils/
    app_colors.dart

  views/
    expense_list_view.dart
    add_edit_expense_view.dart

  widgets/
    analytics_card.dart
    expense_card.dart
```

## Folder Details

### `main.dart`

This is the starting point of the app.

It handles:

- App start
- GetX setup
- Light theme
- Dark theme
- Home screen loading

### `controllers/`

Controllers contain app logic.

`expense_controller.dart` handles:

- Add expense
- Update expense
- Delete expense
- Load expenses
- Category filter
- Search
- Total calculation
- Category-wise total calculation

`theme_controller.dart` handles:

- Light/dark mode toggle
- Saving theme preference locally

### `models/`

`expense_model.dart` contains the expense data model.

Each expense has:

- `id`
- `title`
- `amount`
- `category`
- `date`

It also converts expense data to JSON and back from JSON for local storage.

### `services/`

`expense_service.dart` handles local storage.

It uses SharedPreferences to save and load expenses.

### `views/`

Views contain screen UI.

`expense_list_view.dart` is the home screen.

`add_edit_expense_view.dart` is used for both adding and editing expenses.

### `widgets/`

Widgets contain reusable UI parts.

`analytics_card.dart` shows total and category-wise expense summary.

`expense_card.dart` shows a single expense item with edit and delete actions.

### `utils/`

`app_colors.dart` contains common colors used in the app.

## App Flow

## 1. Home Screen

When the app opens, the user sees the home screen.

Home screen contains:

- Analytics card
- Search field
- Category filter dropdown
- Expense list
- Add button
- Theme toggle button

## 2. Add Expense Flow

When the user taps the `Add` button:

1. Add Expense screen opens.
2. User enters title, amount, category, and date.
3. User taps `Save Expense`.
4. Form validation runs.
5. If data is valid, expense is saved.
6. User returns to home screen.
7. New expense appears in the list.

## 3. Edit Expense Flow

When the user taps the edit icon on an expense card:

1. Edit Expense screen opens.
2. Old expense data is already filled in the form.
3. User changes required details.
4. User taps `Update Expense`.
5. Updated data is saved.
6. Home screen shows updated expense.

## 4. Delete Expense Flow

When the user taps the delete icon:

1. Delete confirmation popup opens.
2. If user taps `Cancel`, popup closes and expense remains same.
3. If user taps `Delete`, expense is removed.
4. Updated list is saved locally.

Keyboard focus is also handled, so keyboard does not reopen after cancelling the delete popup.

## 5. Search Flow

User can type in the search field.

Search works by:

- Expense title
- Expense category

If search text matches an expense, that expense remains visible.

The clear icon removes search text.

## 6. Category Filter Flow

User can select category from dropdown.

Categories:

```text
All
Food
Travel
Shopping
Recharge
Other
```

If user selects `All`, all expenses are shown.

If user selects a specific category, only that category expenses are shown.

Search and category filter work together.

## 7. Analytics Flow

Analytics card shows:

- Total expense amount
- Category-wise expense total

Example:

```text
Total Expense: ₹5000
Food: ₹2000
Travel: ₹1500
Shopping: ₹1500
```

Analytics updates automatically when expense is added, edited, or deleted.

## 8. Theme Flow

App supports light mode and dark mode.

When user taps the theme icon in the AppBar:

1. Theme changes between light and dark.
2. Theme preference is saved locally.
3. When app opens again, last selected theme is restored.

## Local Storage

The app uses SharedPreferences for local storage.

Expense data is saved using this key:

```dart
expense_list
```

Theme mode is saved using this key:

```dart
is_dark_mode
```

Expenses are converted into JSON strings before saving.

When app starts, saved JSON data is loaded and converted back into expense objects.

## State Management

GetX is used for state management.

Reactive values:

```dart
expenses
selectedCategory
searchText
isDarkMode
```

The UI uses `Obx`, so whenever data changes, UI updates automatically.

## Validation

Validation is added in Add/Edit Expense screen.

Rules:

- Title cannot be empty.
- Title allows only letters, numbers, and spaces.
- Amount cannot be empty.
- Amount field accepts digits only.
- Amount keyboard opens in number mode.

## UI Details

The app uses a clean blue and teal color combination.

Main colors:

```text
Primary Blue: #2563EB
Secondary Teal: #14B8A6
Light Background: #F5F7FB
Dark Background: #111827
Dark Card: #1F2937
```

UI points:

- Analytics card uses gradient.
- Add/Edit screen uses gradient header.
- Expense cards are compact.
- Delete popup uses red and blue design.
- Light mode and dark mode are supported.
- UI is responsive and avoids overflow.

## Responsive Handling

The app includes:

- `SafeArea`
- `TextOverflow.ellipsis`
- `FittedBox` for analytics amount
- `isExpanded` for dropdowns
- Bottom padding for list so floating button does not hide content

## App Navigation

Navigation is managed using GetX with smooth screen transitions.

```dart
Transition.rightToLeft
```

## How To Run

Run these commands:

```bash
flutter pub get
flutter run
```

For a clean run:

```bash
flutter clean
flutter pub get
flutter run
```

## Testing

Project was checked using:

```bash
flutter analyze
flutter test
```

Both commands passed successfully.

## Summary

This app is built with a clean and simple structure.

It includes proper MVC separation, GetX state management, SharedPreferences local storage, CRUD operations, search, filter, analytics, validation, theme support, and responsive UI.

