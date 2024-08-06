// app/assets/javascripts/application.js
document.addEventListener("DOMContentLoaded", function() {
    const searchForm = document.querySelector("form[role='search']");
    const searchInput = searchForm.querySelector("input[name='query']");

    searchForm.addEventListener("submit", function(event) {
        if (searchInput.value.trim() === "") {
            event.preventDefault();
            alert("Введите запрос для поиска.");
        }
    });
});
