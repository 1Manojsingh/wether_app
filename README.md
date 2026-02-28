# Weather App 🌤️

A Flutter weather application that fetches live weather data and displays current conditions, forecasts, and daily quotes.

## 📱 Features

- **Current Weather Display**
  - Real-time temperature, condition, and weather icons
  - Humidity and wind speed metrics
  - "Feels like" temperature
  - City search functionality

- **5-Day Weather Forecast**
  - Interactive forecast cards with tap-to-select
  - Daily min/max temperatures
  - Weather condition icons from WeatherAPI
  - 24-hour hourly forecast for selected day

- **Thought of the Day**
  - Daily inspirational quotes from Quotable API
  - Author attribution
  - Graceful fallback handling for network issues

- **Theme Support**
  - Light and Dark mode
  - Theme persistence using SharedPreferences
  - Smooth theme transitions

- **Loading States**
  - Shimmer effects for better UX
  - Complete page shimmer during initial load
  - Section-specific loaders

- **Error Handling**
  - User-friendly error messages
  - Retry functionality
  - Network error handling with fallbacks

- **Animations**
  - Smooth fade and slide transitions
  - Animated temperature counters
  - Staggered list animations
  - Interactive forecast card animations

## 🛠️ Tech Stack

### State Management
- **flutter_riverpod (^3.2.0)** - Modern state management solution
  - **Why**: Provides type-safe, testable state management with excellent DevTools support
  - **Usage**: Manages weather data, quotes, theme preferences, and provider lifecycle

### Routing
- **auto_route (^11.1.0)** - Code generation for routes
  - **Why**: Type-safe routing with compile-time route generation
  - **Usage**: Handles navigation and route configuration
- **auto_route_generator (^10.4.0)** - Code generator for auto_route

### HTTP & Networking
- **dio (^5.4.0)** - Powerful HTTP client
  - **Why**: Advanced features like interceptors, request/response transformation, and better error handling
  - **Usage**: Primary HTTP client for WeatherAPI calls
- **http (^1.2.2)** - Standard HTTP package
  - **Why**: Simple, lightweight for basic API calls
  - **Usage**: Used for Quotable API (separate from WeatherAPI)
- **pretty_dio_logger (^1.3.1)** - Beautiful Dio request/response logger
  - **Why**: Debug-friendly logging for API calls during development
  - **Usage**: Interceptor for Dio to log all network requests/responses

### Data Handling
- **dartz (^0.10.1)** - Functional programming utilities
  - **Why**: Provides `Either` type for better error handling (Left = Failure, Right = Success)
  - **Usage**: Used in HTTP service layer for type-safe error handling
- **equatable (^2.0.8)** - Value equality for Dart objects
  - **Why**: Simplifies object comparison and reduces boilerplate
  - **Usage**: Used in model classes for better equality checks

### Local Storage
- **shared_preferences (^2.5.4)** - Persistent key-value storage
  - **Why**: Simple, efficient storage for user preferences
  - **Usage**: Stores theme preference (light/dark mode)

### UI/UX Libraries
- **shimmer (^3.0.0)** - Shimmer loading effect
  - **Why**: Provides elegant loading placeholders that match content structure
  - **Usage**: Loading states for weather data and quotes
- **intl (^0.19.0)** - Internationalization and date formatting
  - **Why**: Proper date/time formatting for different locales
  - **Usage**: Formats dates (e.g., "Mon, 15 Jan", "2PM", "Monday, 15 January")
- **cached_network_image (^3.4.1)** - Cached network images
  - **Why**: Efficient image loading with caching and placeholder support
  - **Usage**: Displays weather condition icons from WeatherAPI

### UI Components (Legacy/Unused)
- **flutter_svg (^2.2.3)** - SVG rendering
- **lottie (^3.3.2)** - Lottie animations
- **video_player (^2.9.2)** - Video playback
- **marquee (^2.3.0)** - Scrolling text
- **dotted_line (^3.2.3)** - Dotted line widgets
- **country_picker (^2.0.27)** - Country selection
- **syncfusion_flutter_datepicker (^32.2.5)** - Date picker
- **responsive_framework (^1.5.1)** - Responsive layouts

## 📁 Project Structure

```
lib/
├── core/                          # Core functionality shared across features
│   ├── config/                    # App configuration (API keys, URLs)
│   ├── constants/                 # App constants and paths
│   ├── exceptions/                # Custom exception classes
│   ├── extensions/                # Dart extensions
│   ├── model/                     # Shared data models
│   ├── provider_observers/        # Riverpod observers (logging)
│   ├── providers/                 # Core providers (theme, prefs)
│   ├── router/                    # AutoRoute configuration
│   ├── services/                  # Core services (HTTP, notifications)
│   ├── theme/                     # App theming (colors, text styles)
│   ├── utilities/                 # Utility functions and mixins
│   └── wigdets/                   # Reusable core widgets
│       ├── app_button.dart
│       ├── app_padding.dart
│       ├── error_section.dart     # Error display widget
│       ├── search_field.dart      # City search input
│       └── labeled_widget.dart
│
└── features/                      # Feature modules
    └── home/                      # Home/Weather feature
        ├── home_page.dart         # Main weather page
        ├── models/                # Weather data models
        │   └── weather_models.dart
        ├── providers/             # Feature-specific providers
        │   └── weather_providers.dart
        ├── repositories/          # Data layer
        │   ├── home_repository.dart      # Abstract interface
        │   └── http_home_repository.dart # HTTP implementation
        ├── shimmer/               # Loading shimmer effects
        │   ├── home_page_shimmer.dart    # Full page shimmer
        │   └── section_loader.dart       # Section shimmer
        └── widgets/               # Feature-specific widgets
            ├── current_weather_card.dart
            ├── forecast_details_card.dart
            ├── forecast_item.dart
            ├── hourly_forecast_item.dart
            ├── quote_card.dart
            └── weather_metric_chip.dart
```

## 🏗️ Architecture

### Clean Architecture Principles

The project follows **Clean Architecture** with clear separation of concerns:

1. **Presentation Layer** (`features/home/widgets/`, `home_page.dart`)
   - UI components and widgets
   - State management with Riverpod
   - User interactions

2. **Domain Layer** (`features/home/repositories/home_repository.dart`)
   - Abstract repository interfaces
   - Business logic contracts

3. **Data Layer** (`features/home/repositories/http_home_repository.dart`)
   - API implementations
   - Data models (`weather_models.dart`)
   - HTTP service integration

### Design Patterns Used

- **Repository Pattern**: Abstracts data sources (`HomeRepository` interface)
- **Provider Pattern**: Riverpod for state management
- **Dependency Injection**: Riverpod providers for dependency management
- **Observer Pattern**: Provider observers for logging and debugging

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (3.10.7 or higher)
- FVM (Flutter Version Manager) - Recommended
- Dart SDK (comes with Flutter)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd wether_app
   ```

2. **Install dependencies**
   ```bash
   fvm flutter pub get
   ```

3. **Generate route files** (if needed)
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   fvm flutter run
   ```

### API Configuration

The app uses two APIs:

1. **WeatherAPI** (`https://api.weatherapi.com/v1`)
   - API Key: Configured in `lib/core/config/config.dart`
   - Endpoint: `/forecast.json`
   - Provides: Current weather + 5-day forecast

2. **Quotable API** (`https://api.quotable.io`)
   - No API key required
   - Endpoint: `/random`
   - Provides: Random inspirational quotes

**Note**: The WeatherAPI key is currently hardcoded. For production, consider using environment variables or secure storage.

## 📊 Data Flow

```
User Action (Search City)
    ↓
HomePage (UI Layer)
    ↓
weatherProvider (Riverpod)
    ↓
HttpHomeRepository (Data Layer)
    ↓
DioHttpService (HTTP Client)
    ↓
WeatherAPI
    ↓
WeatherBundle Model
    ↓
CurrentWeatherCard / ForecastItem (UI)
```

## 🎨 Key Features Implementation

### Weather Data Fetching
- Uses `DioHttpService` for WeatherAPI calls
- Implements `HomeRepository` pattern for abstraction
- Handles errors gracefully with user-friendly messages
- Supports city search with validation

### Theme Management
- Theme preference stored in `SharedPreferences`
- `themeBrightnessProvider` watches preference changes
- Smooth transitions between light/dark modes
- Theme toggle button in AppBar

### Loading States
- **HomePageShimmer**: Complete page shimmer during initial load
- **SectionLoader**: Individual section shimmer for quotes
- Shimmer colors adapt to light/dark theme

### Animations
- `AnimatedSwitcher` for smooth content transitions
- `TweenAnimationBuilder` for staggered list animations
- Temperature counter animation
- Forecast card selection animations

## 🔧 Development

### Running Tests
```bash
fvm flutter test
```

### Code Generation
```bash
fvm flutter pub run build_runner watch
```

### Analyzing Code
```bash
fvm flutter analyze
```

## 📝 Code Style

- Follows Flutter/Dart style guidelines
- Uses `flutter_lints` for linting
- Consistent naming conventions
- Proper widget composition and separation

## 🐛 Error Handling

The app implements comprehensive error handling:

- **Network Errors**: Handled with fallback messages
- **API Errors**: Parsed and displayed user-friendly messages
- **Invalid City**: Shows "No matching location found" message
- **Quote API Failures**: Falls back to static inspirational quotes

## 🎯 Future Enhancements

Potential improvements:
- Location-based weather (GPS)
- Weather alerts and notifications
- Historical weather data
- Multiple city favorites
- Weather maps integration
- Unit conversion (Celsius/Fahrenheit)

## 📄 License

This project is for educational/demonstration purposes.

## 👤 Author

Built as a production-ready Flutter weather application demonstrating:
- Clean Architecture
- State Management (Riverpod)
- API Integration
- Modern UI/UX Design
- Error Handling
- Loading States
- Theme Management

---

**Note**: This project uses FVM (Flutter Version Manager) for Flutter SDK management. Make sure FVM is installed and configured before running the project.
