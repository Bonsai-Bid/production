export function updateCountdown(element) {
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
