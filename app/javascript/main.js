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

//Автоматическое исчезновение уведомлений
document.addEventListener('turbo:load', function() {
    // Находим все элементы с классом alert
    const alerts = document.querySelectorAll('.alert');

    // Запускаем таймер на их удаление через 5 секунд
    alerts.forEach(function(alert) {
        setTimeout(function() {
            // Плавное исчезновение
            alert.classList.add('fade-out');
            // Когда завершится анимация, элемент удалится
            alert.addEventListener('transitionend', function() {
                alert.remove();
            });
        }, 5000); // Исчезновение через 5 секунд
    });
});


