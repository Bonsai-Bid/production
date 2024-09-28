import { handleCategoryVisibility } from './handleCategoryVisibility'; // Adjust the path as necessary


export function handleSelectChange(selectElement) {
  console.log(selectElement); // Debugging log to check if element exists
  if (!selectElement) {
    console.error("selectElement is undefined or null.");
    return;
  }
  
  const selectedValue = selectElement.value;
  console.log("Handling select change, new value:", selectedValue);

  // Trigger the visibility logic for categories
  handleCategoryVisibility(selectedValue);
}
