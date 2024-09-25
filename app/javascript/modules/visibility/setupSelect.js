
export function setupSelect(selectElement, otherElement) {
  handleSelectChange(selectElement, otherElement);

  selectElement.addEventListener('change', () => {
    handleSelectChange(selectElement, otherElement);
  });
}
