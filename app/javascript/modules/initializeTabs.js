import { handleTabSwitch } from './handleTabSwitch';

export function initializeTabs() {
  const tabButtons = document.querySelectorAll('.tab-button');
  const contentTabs = document.querySelectorAll('.content-tab');

  if (tabButtons.length && contentTabs.length) {
    handleTabSwitch(tabButtons, contentTabs);
  }
}
