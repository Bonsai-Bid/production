import { toggleVisibility } from './toggleVisibility';

export function initializeBuyItNow() {
  const buyItNowCheckbox = document.getElementById('enable_buy_it_now');
  const buyItNowPriceField = document.getElementById('buy_it_now_price_field');

  if (buyItNowCheckbox && buyItNowPriceField) {
    toggleVisibility(buyItNowCheckbox, buyItNowPriceField);
  }
}
