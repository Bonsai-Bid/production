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

function updateCountdown(element) {
  const endDate = new Date(element.dataset.endDate);
  const now = new Date();
  const timeDiff = endDate - now;

  if (timeDiff > 0) {
    const hours = Math.floor(timeDiff / (1000 * 60 * 60)).toString().padStart(2, '0');
    const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60)).toString().padStart(2, '0');
    const seconds = Math.floor((timeDiff % (1000 * 60)) / 1000).toString().padStart(2, '0');
    element.textContent = `${hours}:${minutes}:${seconds} remaining`;
  } else {
    element.textContent = "Auction ended";
  }
}
