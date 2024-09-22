import { updateCountdown } from './updateCountdown';

export function initializeCountdown() {
  const countdownElements = document.querySelectorAll("[id^=countdown-]");

  countdownElements.forEach(element => {
    const timeDiff = new Date(element.dataset.endDate) - new Date();
    // Start countdown if less than 24 hours remain
    if (timeDiff < 24 * 60 * 60 * 1000) {
      setInterval(() => updateCountdown(element), 1000);
    }
  });
}
