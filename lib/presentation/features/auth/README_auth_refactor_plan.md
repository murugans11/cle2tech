# Authentication Feature Refactor Plan (Presentation Layer)

This document outlines the plan for relocating and refactoring existing presentation layer components for the Authentication feature into the new Clean Architecture structure.

## Blocs & Cubits

No Blocs or Cubits directly and solely responsible for user authentication (e.g., LoginBloc, SignUpBloc, OtpBloc) were identified in the existing `lib/blocs/` or `lib/cubit/` directories.

**Refactoring Notes:**
*   New Blocs/Cubits specific to authentication will be created within `lib/presentation/features/auth/blocs/` or `lib/presentation/features/auth/cubits/`.
*   These new Blocs/Cubits will utilize the domain layer use cases (e.g., `LoginUser`, `SignUpUser`, `RequestOtp`, `VerifyOtp`, `GetCurrentUser`, `LogoutUser`).
*   Their states and events will be designed to align with the inputs and outputs of these use cases and the needs of the UI.

## Pages/Screens

The following pages/screens from `lib/pages/auth_screen/` will be moved to `lib/presentation/features/auth/pages/`:

*   **Current:** `lib/pages/auth_screen/change_pass_screen.dart`
    **New Path:** `lib/presentation/features/auth/pages/change_pass_screen.dart`
    **Refactoring Notes:** UI will likely remain similar. Will need to interact with new auth-related Blocs/Cubits or use cases for password change functionality (which might require new use cases like `ChangePasswordUseCase`).

*   **Current:** `lib/pages/auth_screen/forgot_pass_screen.dart`
    **New Path:** `lib/presentation/features/auth/pages/forgot_pass_screen.dart`
    **Refactoring Notes:** UI will likely remain similar. Will interact with new auth-related Blocs/Cubits (e.g., for requesting a password reset OTP/link, potentially using `RequestOtpUseCase` if applicable, or a new `ForgotPasswordUseCase`).

*   **Current:** `lib/pages/auth_screen/log_in_screen.dart`
    **New Path:** `lib/presentation/features/auth/pages/log_in_screen.dart`
    **Refactoring Notes:** UI will remain similar. Will be updated to interact with a new `LoginBloc` (or similar) which uses the `LoginUser` use case.

*   **Current:** `lib/pages/auth_screen/otp_auth_screen.dart`
    **New Path:** `lib/presentation/features/auth/pages/otp_auth_screen.dart`
    **Refactoring Notes:** UI will remain similar. Will be updated to interact with a new `OtpBloc` (or similar) which uses the `VerifyOtpUseCase` and potentially `RequestOtpUseCase`.

*   **Current:** `lib/pages/auth_screen/otp_test.dart`
    **New Path:** `lib/presentation/features/auth/pages/otp_test.dart`
    **Refactoring Notes:** This seems like a test or debug screen. It might be removed or refactored for testing purposes within the new structure. If kept, it will use the new auth Blocs/Cubits.

*   **Current:** `lib/pages/auth_screen/sign_up.dart`
    **New Path:** `lib/presentation/features/auth/pages/sign_up.dart`
    **Refactoring Notes:** UI will remain similar. Will be updated to interact with a new `SignUpBloc` (or similar) which uses the `SignUpUser` use case.

## Widgets

No highly specific, standalone authentication widgets were identified in `lib/widgets/` during the initial review (e.g., a custom OTP input field widget). Widgets like `social_media_button.dart` are generic enough to remain in `lib/widgets/` or a common widgets directory.

**Refactoring Notes:**
*   If any widgets within the existing auth pages (`lib/pages/auth_screen/*`) are identified as reusable specifically within the auth feature, they will be extracted and moved to `lib/presentation/features/auth/widgets/`.
*   Common widgets (e.g., generic buttons, text fields) will continue to be used from `lib/widgets/` or a shared common widgets directory.
*   Widgets within the auth pages will be updated to interact with the new auth Blocs/Cubits.
