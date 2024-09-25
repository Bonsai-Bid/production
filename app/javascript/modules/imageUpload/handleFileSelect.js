

let filesArray = [];

export function handleFileSelect(event) {
  const newFiles = Array.from(event.target.files);
  filesArray = [...filesArray, ...newFiles]; // Spread operator to concatenate

  updateImagePreview(filesArray); // Pass the array to the update function
  event.target.value = ''; // Clear the file input
}

export function getFilesArray() {
  return filesArray;
}
