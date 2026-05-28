# Daily Expense Tracker App - Project Details

## Project Overview

This is a simple Flutter Daily Expense Tracker app.

The main purpose of this app is to help users save and manage their daily expenses locally on their phone.

Users can:

- Add a new expense
- View all expenses
- Edit an existing expense
- Delete an expense
- Filter expenses by category
- View simple analytics/category totals
- Switch between light mode and dark mode

The app is built with a clean beginner-friendly structure using MVC, GetX, and SharedPreferences.

## Tech Stack

- Flutter
- Dart
- GetX
- SharedPreferences
- Material Design 3

## Packages Used

Packages are added in `pubspec.yaml`.

```yaml
get: ^4.7.3
shared_preferences: ^2.5.5
```

### Why GetX?

GetX is used for:

- State management
- Navigation
- Theme switching
- Reactive UI updates using `Obx`

### Why SharedPreferences?

SharedPreferences is used for local storage.

It stores:

- Expense list
- Dark mode / light mode preference

So when the user closes and reopens the app, the saved data is still available.

## Folder Structure

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

## File Details

### `lib/main.dart`

This is the app starting point.

Main work done here:

- Starts the Flutter app
- Initializes `ThemeController`
- Uses `GetMaterialApp`
- Defines light theme
- Defines dark theme
- Opens `ExpenseListView` as the home screen

## MVC Structure

The project follows a simple MVC style structure.

### Model

Model file:

```text
lib/models/expense_model.dart
```

`ExpenseModel` stores one expense item.

Fields:

- `id`
- `title`
- `amount`
- `category`
- `date`

It also has methods for converting data:

- `toMap()`
- `fromMap()`
- `toJson()`
- `fromJson()`

This is needed because SharedPreferences stores data as strings.

### View

View files:

```text
lib/views/expense_list_view.dart
lib/views/add_edit_expense_view.dart
```

Views are responsible for UI screens.

They show data and call controller methods.

### Controller

Controller files:

```text
lib/controllers/expense_controller.dart
lib/controllers/theme_controller.dart
```

Controllers handle app logic.

They keep UI and logic separate.

### Service

Service file:

```text
lib/services/expense_service.dart
```

Service handles local storage work.

It saves and loads expenses using SharedPreferences.

## State Management

State management is handled using GetX.

Main reactive variables:

```dart
final expenses = <ExpenseModel>[].obs;
final selectedCategory = 'All'.obs;
final isDarkMode = false.obs;
```

The UI uses `Obx()` to automatically update when data changes.

Example:

- If a new expense is added, list updates automatically.
- If category filter changes, list updates automatically.
- If theme changes, app switches light/dark mode.

## Local Storage

Local storage is handled in:

```text
lib/services/expense_service.dart
```

Storage key:

```dart
static const String expenseKey = 'expense_list';
```

How it works:

1. Expense data is converted to JSON string.
2. JSON strings are saved in SharedPreferences using `setStringList`.
3. When app opens, saved strings are loaded using `getStringList`.
4. JSON strings are converted back to `ExpenseModel`.

Theme preference is saved in:

```text
lib/controllers/theme_controller.dart
```

Theme key:

```dart
static const String themeKey = 'is_dark_mode';
```

## App Features

## 1. Expense List

File:

```text
lib/views/expense_list_view.dart
```

The home screen shows:

- Analytics card
- Category filter dropdown
- Expense cards list
- Add button
- Dark/light mode toggle

Each expense card shows:

- Category icon
- Expense title
- Category name
- Date
- Amount
- Edit button
- Delete button

## 2. Add Expense

File:

```text
lib/views/add_edit_expense_view.dart
```

User can add:

- Title
- Amount
- Category
- Date

After saving, data is added to controller and stored locally.

## 3. Edit Expense

Same screen is used for add and edit.

If an expense is passed to the screen, old data is filled in the form.

Then user can update it.

## 4. Delete Expense

Delete action is available on every expense card.

Before deleting, a custom confirmation popup is shown.

Popup contains:

- Delete icon
- Confirmation message
- Cancel button
- Delete button

This prevents accidental deletion.

## 5. Category Filter

Categories:

```text
All
Food
Travel
Shopping
Recharge
Other
```

User can select a category from dropdown.

If `All` is selected, all expenses are shown.

If any specific category is selected, only that category expenses are shown.

## 6. Analytics Section

File:

```text
lib/widgets/analytics_card.dart
```

Analytics card shows:

- Total expense
- Category-wise total

Example:

```text
Total Expense: Rs 5000
Food: Rs 1500
Travel: Rs 1000
Shopping: Rs 2500
```

Logic is written in `ExpenseController`.

## 7. Validation

Validation is added in add/edit form.

Rules:

- Title cannot be empty
- Amount cannot be empty
- Amount must be a valid number

If validation fails, user cannot save the form.

## 8. Light Mode and Dark Mode

Theme controller:

```text
lib/controllers/theme_controller.dart
```

The app supports:

- Light mode
- Dark mode

User can toggle theme from the AppBar icon.

Theme preference is saved locally using SharedPreferences.

So selected theme remains same after app restart.

## 9. Screen Animation

GetX navigation animation is added when moving to Add/Edit screen.

Used transition:

```dart
Transition.rightToLeft
```

This gives a smooth screen switch effect.

## UI and Color Combination

Color file:

```text
lib/utils/app_colors.dart
```

Main colors:

```dart
primary = Color(0xFF2563EB)
secondary = Color(0xFF14B8A6)
background = Color(0xFFF5F7FB)
darkBackground = Color(0xFF111827)
darkCard = Color(0xFF1F2937)
textDark = Color(0xFF1F2937)
textLight = Color(0xFF6B7280)
```

UI color usage:

- Blue and teal gradient is used for analytics card.
- Add/Edit screen has gradient header.
- Light mode has soft background.
- Dark mode has dark background and dark cards.
- Expense cards use category-based circle colors.
- In light mode, edit icon and amount are black.
- In light mode, delete icon is light red.
- In dark mode, edit icon, delete icon, and amount are white.

## Responsive UI

Responsive care is added in UI:

- `SafeArea` is used on screens.
- Expense title uses `maxLines` and `TextOverflow.ellipsis`.
- Amount uses `TextOverflow.ellipsis`.
- Dropdown uses `isExpanded: true`.
- Analytics total uses `FittedBox`.
- List has bottom padding so FAB does not hide content.

This helps avoid overflow on small screens.

## Widgets

### `lib/widgets/expense_card.dart`

This widget displays one expense item.

It contains:

- Category circle
- Title
- Category/date
- Amount
- Edit icon
- Delete icon

### `lib/widgets/analytics_card.dart`

This widget displays:

- Total expense
- Category-wise totals

It uses a gradient background for a clean look.

## Data Flow

Simple app flow:

```text
User fills form
        ↓
ExpenseController add/update method runs
        ↓
ExpenseModel object is created/updated
        ↓
ExpenseService saves data in SharedPreferences
        ↓
Obx updates UI automatically
```

## CRUD Operations

### Add

Method:

```dart
addExpense()
```

Adds new expense and saves data.

### Read

Method:

```dart
loadExpenses()
```

Loads saved expenses from local storage.

### Update

Method:

```dart
updateExpense()
```

Finds expense by `id` and updates it.

### Delete

Method:

```dart
deleteExpense()
```

Removes expense by `id` and saves updated list.

## Testing and Verification

The project was checked using:

```bash
flutter analyze
flutter test
```

Both commands passed successfully.

## Final Summary

This project is a simple and clean Daily Expense Tracker app.

It includes:

- Proper folder structure
- MVC pattern
- GetX state management
- SharedPreferences local storage
- CRUD operations
- Category filter
- Analytics summary
- Light/dark mode
- Screen transition animation
- Responsive UI
- Form validation
- Clean beginner-friendly code

