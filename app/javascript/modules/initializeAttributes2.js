import { setupSelect } from './setupSelect';
import { handleSelectChange } from './handleSelectChange';

export function initializeAttributes() {
  const selectElements = document.querySelectorAll('select[id^="item_"]');
  selectElements.forEach(selectElement => {
    const otherElementId = `item_${selectElement.id.split('_').slice(1).join('_')}_other`;
    const otherElement = document.getElementById(otherElementId);
    setupSelect(selectElement, otherElement);
  });

  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('reset', () => {
      setTimeout(() => {
        selectElements.forEach(selectElement => {
          const otherElementId = `item_${selectElement.id.split('_').slice(1).join('_')}_other`;
          const otherElement = document.getElementById(otherElementId);
          handleSelectChange(selectElement, otherElement);
        });
      }, 0); // Delay to allow form reset to complete
    });
  });
}
