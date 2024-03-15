# The Met

"The Met" is an app that provides access to more than 470.000 artworks from ["The Metropolitan Museum of Art"](https://www.metmuseum.org) that are in the [public domain (PD)](https://en.wikipedia.org/wiki/Public_domain).

#
**List of Departments:**
- American Decorative Arts
- Ancient Near Eastern Art
- Arms and Armor
- Arts of Africa, Oceania, and the Americas
- Asian Art
- The Cloisters
- The Costume Institute
- Drawings and Prints
- Egyptian Art
- European Paintings
- European Sculpture and Decorative Arts
- Greek and Roman Art
- Islamic Art
- The Robert Lehman Collection
- The Libraries
- Medieval Art
- Musical Instruments
- Photographs
- Modern Art (mostly not in PD)

![](https://github.com/eldarovsky/The-Met/blob/main/images/Image_01.png)
![](https://github.com/eldarovsky/The-Met/blob/main/images/Image_02.png)
#
**ТЕХНОЛОГИИ:**
- Архитектура: MVP+C (C - в данном случае Router) и MVC (для одной сцены)
- Состав сцены: Assembler, ViewController, Presenter, Router
- Взаимодействие файлов сцены через протоколы
- Паттерны: singletone, delegate
- Целенаправленно использованы только нативные фреймворки: Foundation, UIKit
- Верстка интерфейса велась полностью кодом
- Хранение данных: UserDefaults для hashValue изображения
- Применены кастомные цвета для создания более привлекательного интерфейса
#
**ФУНКЦИОНАЛЬНОСТЬ:**
- Использованы индикатор загрузки и активности для лучшего UX
- Загрузка из сети и отображение изображений с подробной информаций
- Масштабирование (по двойному тапу до х2, вручную - до х4) и скроллинг открытого изображения
- Возможность сохранения изображений в фотоальбом устройства
- Асинхронная ограниченная временем загрузка данных с использованием GCD
- Отображение уведомлений при ошибке загрузки, сохранении изображения или повторной попытке
- Повторная загрузка по нажатию на кнопку "Retry" в уведомлении, в таблице - потянув ячейки вниз
- Предотвращено повторное сохранение изображения в текущей сессии
- Реализована тактильная обратная связь при нажатии на кнопку "Next"
- Используется анимация появления ячеек таблицы
- Цветовая схема приложения задана явно
#
**ПЛАН РАЗВИТИЯ:**
- Полный перевод приложения в архитектуру MVP
- Рассмотреть необходимость использования сторонних фреймворков
- Добавить поиск изображений по ключевым словам (реализовано в MVC на ветке "searchScene")
- Реализовать ручную пагинацию для экрана поиска
- Добавить возможность голосового набора в поле поиска
- Добавить возможность сохранения изображений в избранное
- Добавить возможность выбора одной из двух цветовых схем приложения
- Добавить возможность включения-отключения звуковых и тактильных эффектов
- Добавить обработку сценария отсутствия интернет-соединения
- Использование векторных изображений в интерфейсе
- Задокументировать код
- Добавить тесты
- Рефакторинг кода
