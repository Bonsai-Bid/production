// app/javascript/controllers/auction_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["buyItNowPriceField", "reservePriceField", "listLaterFields", "endTimeFields"]

  connect() {
    // Ensure the correct fields are shown or hidden on initial page load
    this.toggleBuyItNowPrice();
    this.toggleReservePrice();
    this.toggleListLaterFields();
  }

  // Toggles the Buy It Now price field based on checkbox
  toggleBuyItNowPrice() {
    const buyItNowCheckbox = document.getElementById("item_auction_enable_buy_it_now");
    const buyItNowPriceField = this.buyItNowPriceFieldTarget;

    if (buyItNowCheckbox.checked) {
      buyItNowPriceField.classList.remove("hidden");
    } else {
      buyItNowPriceField.classList.add("hidden");
    }
  }

  // Toggles the Reserve Price field based on checkbox
  toggleReservePrice() {
    const reservePriceCheckbox = document.getElementById("item_auction_enable_reserve_price");
    const reservePriceField = this.reservePriceFieldTarget;

    if (reservePriceCheckbox.checked) {
      reservePriceField.classList.remove("hidden");
    } else {
      reservePriceField.classList.add("hidden");
    }
  }

  // Toggles the List Later fields based on the selected timing option
  toggleListLaterFields() {
    const listLaterRadio = document.getElementById("list_later");
    const listLaterFields = this.listLaterFieldsTarget;

    if (listLaterRadio && listLaterRadio.checked) {
      listLaterFields.classList.remove("hidden");
    } else {
      listLaterFields.classList.add("hidden");
    }
  }

  // Toggles the End Time fields when "Set Different End Time" is clicked
  toggleEndTime() {
    const endTimeFields = this.endTimeFieldsTarget;

    if (endTimeFields.classList.contains("hidden")) {
      endTimeFields.classList.remove("hidden");
    } else {
      endTimeFields.classList.add("hidden");
    }
  }
}
