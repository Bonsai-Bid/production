export function initializeCountdown() {
  const countdownElements = document.querySelectorAll("[id^=countdown-]");

  countdownElements.forEach(element => {
    // Initialize the countdown and update it every second
    updateCountdown(element);
    
    // If the countdown is less than 24 hours, set an interval to update it every second
    if (new Date(element.dataset.endDate) - new Date() < 24 * 60 * 60 * 1000) {
      setInterval(() => updateCountdown(element), 1000);
    }
  });
}


