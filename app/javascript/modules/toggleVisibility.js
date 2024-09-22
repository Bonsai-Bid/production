export function toggleVisibility(condition, elementsToShow = [], elementsToHide = []) {
  // Hide all fields in the elementsToHide array
  elementsToHide.forEach(element => {
    if (element) element.classList.add('hidden');
  });

  // Show all fields in the elementsToShow array if the condition is met
  if (condition) {
    elementsToShow.forEach(element => {
      if (element) element.classList.remove('hidden');
    });
  }
}
