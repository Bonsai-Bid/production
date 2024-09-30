export function toggleVisibility(condition, elementsToShow = [], elementsToHide = []) {
  console.log("Toggling visibility, condition:", condition);

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
