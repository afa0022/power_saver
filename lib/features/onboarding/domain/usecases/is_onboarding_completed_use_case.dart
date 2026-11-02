import '../repositories/onboarding_repository.dart';

class IsOnboardingCompletedUseCase {
  final OnboardingRepository repository;

  const IsOnboardingCompletedUseCase(this.repository);

  Future<bool> call() {
    return repository.isOnboardingCompleted();
  }
}
