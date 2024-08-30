document.addEventListener('turbolinks:load', () => {
  const buyItNowCheckbox = document.getElementById('enable_buy_it_now');
  const buyItNowPriceField = document.getElementById('buy_it_now_price_field');
  const reservePriceCheckbox = document.getElementById('enable_reserve_price');
  const reservePriceField = document.getElementById('reserve_price_field');

  // Only proceed if the elements are present on the page
  if (buyItNowCheckbox && buyItNowPriceField) {
    buyItNowCheckbox.addEventListener('change', () => {
      if (buyItNowCheckbox.checked) {
        buyItNowPriceField.classList.remove('hidden');
      } else {
        buyItNowPriceField.classList.add('hidden');
      }
    });

    // Set initial visibility based on the checkbox state
    if (buyItNowCheckbox.checked) {
      buyItNowPriceField.classList.remove('hidden');
    } else {
      buyItNowPriceField.classList.add('hidden');
    }
  }

  if (reservePriceCheckbox && reservePriceField) {
    reservePriceCheckbox.addEventListener('change', () => {
      if (reservePriceCheckbox.checked) {
        reservePriceField.classList.remove('hidden');
      } else {
        reservePriceField.classList.add('hidden');
      }
    });

    // Set initial visibility based on the checkbox state
    if (reservePriceCheckbox.checked) {
      reservePriceField.classList.remove('hidden');
    } else {
      reservePriceField.classList.add('hidden');
    }
  }
});
