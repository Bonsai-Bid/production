import { handleSelectChange } from './handleSelectChange';

export function setupSelect(selectElement, otherElement) {
  const selectedValue = selectElement.dataset.selectedValue || '';
  selectElement.value = selectedValue;
  console.log(`Initial selected value for ${selectElement.id}: ${selectedValue}`);
  handleSelectChange(selectElement, otherElement);

  selectElement.addEventListener('change', () => handleSelectChange(selectElement, otherElement));
}
