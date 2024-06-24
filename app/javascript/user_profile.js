// app/javascript/entrypoints/user_profile.js
document.addEventListener('DOMContentLoaded', () => {
  const tabButtons = document.querySelectorAll('.tab-button');
  const contentTabs = document.querySelectorAll('.content-tab');

  tabButtons.forEach(button => {
    button.addEventListener('click', () => {
      const targetTab = button.textContent.toLowerCase().replace(' ', '-');

      contentTabs.forEach(tab => {
        if (tab.id === targetTab) {
          tab.classList.remove('hidden');
        } else {
          tab.classList.add('hidden');
        }
      });
    });
  });
});
