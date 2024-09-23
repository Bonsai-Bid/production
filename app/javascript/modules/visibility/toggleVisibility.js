export function toggleVisibility(condition, elementsToShow = [], elementsToHide = []) {
  elementsToShow.forEach(element => {
    if (element) element.classList.toggle('hidden', !condition);
  });
  elementsToHide.forEach(element => {
    if (element) element.classList.toggle('hidden', condition);
  });
}

  // Hide elements if the condition is true, show otherwise
//   elementsToHide.forEach(element => {
//     if (element) {
//       element.classList.toggle('hidden', condition);
//     }
//   });
// }
