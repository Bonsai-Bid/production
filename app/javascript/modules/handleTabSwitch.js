export function handleTabSwitch(tabButtons, contentTabs) {
  tabButtons.forEach(button => {
    button.addEventListener('click', () => {
      // Remove active class from all buttons
      tabButtons.forEach(btn => btn.classList.remove('active'));
      // Hide all content tabs
      contentTabs.forEach(tab => tab.classList.remove('active'));

      // Add active class to the clicked button
      button.classList.add('active');
      // Show the corresponding content tab
      const tabId = button.dataset.tab;
      document.getElementById(tabId).classList.add('active');
    });
  });
}
