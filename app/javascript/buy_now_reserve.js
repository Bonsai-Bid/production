document.addEventListener('turbolinks:load', () => {
  const buyItNowCheckbox = document.getElementById('enable_buy_it_now');
  const buyItNowPriceField = document.getElementById('buy_it_now_price_field');
  const reservePriceCheckbox = document.getElementById('enable_reserve_price');
  const reservePriceField = document.getElementById('reserve_price_field');

  if (buyItNowCheckbox) {
    buyItNowCheckbox.addEventListener('change', () => {
      if (buyItNowCheckbox.checked) {
        buyItNowPriceField.classList.remove('hidden');
      } else {
        buyItNowPriceField.classList.add('hidden');
      }
    });
  }

  if (reservePriceCheckbox) {
    reservePriceCheckbox.addEventListener('change', () => {
      if (reservePriceCheckbox.checked) {
        reservePriceField.classList.remove('hidden');
      } else {
        reservePriceField.classList.add('hidden');
      }
    });
  }

  // Ensure that the fields are shown or hidden based on the initial state of the checkboxes
  if (buyItNowCheckbox && buyItNowCheckbox.checked) {
    buyItNowPriceField.classList.remove('hidden');
  } else {
    buyItNowPriceField.classList.add('hidden');
  }

  if (reservePriceCheckbox && reservePriceCheckbox.checked) {
    reservePriceField.classList.remove('hidden');
  } else {
    reservePriceField.classList.add('hidden');
  }
});
