class UserData {
  String name;
  String email;
  bool smokes;
  String alcoholFrequency; // 'never', 'sometimes', 'daily'
  String stressLevel;      // 'low', 'medium', 'high'
  int age;
  String riskLevel;        // 'Low', 'Medium', 'High'

  UserData({
    this.name = '',
    this.email = '',
    this.smokes = false,
    this.alcoholFrequency = 'never',
    this.stressLevel = 'low',
    this.age = 22,
    this.riskLevel = '',
  });

  /// Rule-based AI Risk Analysis
  String calculateRisk() {
    int score = 0;

    if (smokes) score += 3;

    if (alcoholFrequency == 'daily') score += 3;
    else if (alcoholFrequency == 'sometimes') score += 1;

    if (stressLevel == 'high') score += 2;
    else if (stressLevel == 'medium') score += 1;

    if (age < 18) score += 1;
    else if (age > 50) score += 1;

    if (score >= 5) return 'High';
    if (score >= 2) return 'Medium';
    return 'Low';
  }

  List<String> getRiskReasons() {
    List<String> reasons = [];
    if (smokes) reasons.add('You smoke regularly');
    if (alcoholFrequency == 'daily') reasons.add('You drink alcohol daily');
    if (alcoholFrequency == 'sometimes') reasons.add('You drink alcohol sometimes');
    if (stressLevel == 'high') reasons.add('You have a high stress level');
    if (stressLevel == 'medium') reasons.add('You have a medium stress level');
    if (age < 18) reasons.add('Young age increases vulnerability');
    if (age > 50) reasons.add('Older age increases health risk');
    if (reasons.isEmpty) reasons.add('No significant risk factors detected');
    return reasons;
  }
}

// Global singleton (simple state management)
UserData currentUser = UserData();