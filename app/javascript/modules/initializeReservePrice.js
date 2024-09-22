import { toggleVisibility } from './toggleVisibility';

export function initializeReservePrice() {
  const reservePriceCheckbox = document.getElementById('enable_reserve_price');
  const reservePriceField = document.getElementById('reserve_price_field');

  if (reservePriceCheckbox && reservePriceField) {
    toggleVisibility(reservePriceCheckbox, reservePriceField);
  }
}
