 // Helper function to calculate the line's position
  double calculateLinePosition(double screenWidth, double margin,int length, int selectedIndex) {
    // Calculate the available width for the navigation bar (excluding margins)
    double availableWidth = screenWidth - (2 * margin);

    // Calculate the width of each icon section
    double iconSectionWidth = availableWidth / length;

    // Calculate the center position of the selected icon
    double iconCenter =
        iconSectionWidth * selectedIndex + iconSectionWidth / 2;

    // Adjust for the line's width to center it
    return iconCenter - 25; // 25 is half of the line's width (50 / 2)
  }