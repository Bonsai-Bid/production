// document.addEventListener("turbolinks:load", () => {
//   const tabButtons = document.querySelectorAll(".tab-button");
//   const contentTabs = document.querySelectorAll(".content-tab");

//   tabButtons.forEach(button => {
//     button.addEventListener("click", () => {
//       // console.log("Tab clicked:", button.textContent);

//       // Remove active class from all buttons
//       tabButtons.forEach(btn => btn.classList.remove("active"));
//       // Hide all content tabs
//       contentTabs.forEach(tab => tab.classList.remove("active"));
      
//       // Add active class to the clicked button
//       button.classList.add("active");
//       // Show the corresponding content tab
//       const tabId = button.dataset.tab;
//       // console.log("Show content for:", tabId);
//       document.getElementById(tabId).classList.add("active");
//     });
//   });
// });