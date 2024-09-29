(() => {
  // app/javascript/main.js
  document.addEventListener("DOMContentLoaded", function() {
    const searchForm = document.querySelector("form[role='search']");
    const searchInput = searchForm.querySelector("input[name='query']");
    searchForm.addEventListener("submit", function(event) {
      if (searchInput.value.trim() === "") {
        event.preventDefault();
        alert("\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u0437\u0430\u043F\u0440\u043E\u0441 \u0434\u043B\u044F \u043F\u043E\u0438\u0441\u043A\u0430.");
      }
    });
  });
})();
//# sourceMappingURL=/assets/main.js.map
