

export function updateImagePreview() {
  const filesArray = getFilesArray(); // Access the global filesArray via the getter
  const imagePreview = document.getElementById('image-preview');
  imagePreview.innerHTML = ''; // Clear previous previews

  filesArray.forEach((file, index) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const imgElement = createImagePreview(e.target.result, index);
      imagePreview.appendChild(imgElement);
    };
    reader.readAsDataURL(file);
  });
}
