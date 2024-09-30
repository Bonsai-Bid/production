import { handleCategoryVisibility } from './handleCategoryVisibility'; // Adjust the path as necessary


export function handleSelectChange(selectElement) {
  console.log(selectElement); // Debugging log to check if element exists
  if (!selectElement) {
    console.error("selectElement is undefined or null.");
    return;
  }
  
  const selectedValue = selectElement.value;
  console.log("Handling category change. Selected value:", selectedValue || "No value selected");

  // Trigger the visibility logic for categories
  handleCategoryVisibility(selectedValue);
}
