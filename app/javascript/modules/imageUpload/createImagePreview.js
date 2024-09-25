export function createImagePreview(src, index) {
  const imgElement = document.createElement('div');
  imgElement.classList.add('relative', 'h-24', 'w-24', 'm-2');

  const img = document.createElement('img');
  img.src = src;
  img.classList.add('h-full', 'w-full', 'object-cover', 'border', 'rounded');

  const removeButton = document.createElement('button');
  removeButton.innerHTML = '&times;';
  removeButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'h-6', 'w-6', 'flex', 'items-center', 'justify-center', 'cursor-pointer');
  removeButton.dataset.index = index;
  
  // Delegated event listener, no need to attach directly here.
  imgElement.appendChild(img);
  imgElement.appendChild(removeButton);

  return imgElement;
}
