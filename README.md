<h1 id="the-met">The Met</h1>

<p>&quot;The Met&quot; is an app that provides access to more than 470.000 artworks from <a href="https://www.metmuseum.org">&quot;The Metropolitan Museum of Art&quot;</a> that are in the <a href="https://en.wikipedia.org/wiki/Public_domain">public domain</a>.</p>

<details>
<summary><strong>LIST OF DEPARTMENTS</strong></summary>
<li>American Decorative Arts</li>
<li>Ancient Near Eastern Art</li>
<li>Arms and Armor</li>
<li>Arts of Africa, Oceania, and the Americas</li>
<li>Asian Art</li>
<li>The Cloisters</li>
<li>The Costume Institute</li>
<li>Drawings and Prints</li>
<li>Egyptian Art</li>
<li>European Paintings</li>
<li>European Sculpture and Decorative Arts</li>
<li>Greek and Roman Art</li>
<li>Islamic Art</li>
<li>The Robert Lehman Collection</li>
<li>The Libraries</li>
<li>Medieval Art</li>
<li>Musical Instruments</li>
<li>Photographs</li>
<li>Modern Art (mostly not in PD)</li>
</details>

<img src="https://github.com/eldarovsky/The-Met/blob/main/images/Image_01.png" alt="">
<img src="https://github.com/eldarovsky/The-Met/blob/main/images/Image_02.png" alt="">

<details>
<summary><strong>ТЕХНОЛОГИИ</strong></summary>
<li>Архитектура: MVP+C (C - в данном случае Router) и MVC (для одной сцены)</li>
<li>Состав сцены: Assembler, ViewController, Presenter, Router</li>
<li>Взаимодействие файлов сцены через протоколы</li>
<li>Паттерны: singletone, delegate</li>
<li>Целенаправленно использованы только нативные фреймворки: Foundation, UIKit</li>
<li>Верстка интерфейса велась полностью кодом</li>
<li>Хранение данных: UserDefaults для hashValue изображения</li>
<li>Применены кастомные цвета для создания более привлекательного интерфейса</li>
</details>

<details>
<summary><strong>ФУНКЦИОНАЛЬНОСТЬ</strong></summary>
<li>Использованы индикатор загрузки и активности для лучшего UX</li>
<li>Загрузка из сети и отображение изображений с подробной информаций</li>
<li>Масштабирование (по двойному тапу до х2, вручную - до х4) и скроллинг открытого изображения</li>
<li>Возможность сохранения изображений в фотоальбом устройства</li>
<li>Асинхронная ограниченная временем загрузка данных с использованием GCD</li>
<li>Отображение уведомлений при ошибке загрузки, сохранении изображения или повторной попытке</li>
<li>Повторная загрузка по нажатию на кнопку "Retry" в уведомлении, в таблице - потянув ячейки вниз</li>
<li>Предотвращено повторное сохранение изображения в текущей сессии</li>
<li>Реализована тактильная обратная связь при нажатии на кнопку "Next"</li>
<li>Используется анимация появления ячеек таблицы</li>
<li>Цветовая схема приложения задана явно</li>
</details>

<details>
<summary><strong>ПЛАН РАЗВИТИЯ</strong></summary>
<li>Полный перевод приложения в архитектуру MVP</li>
<li>Рассмотреть необходимость использования сторонних фреймворков</li>
<li>Добавить поиск изображений по ключевым словам (реализовано в MVC на ветке "searchScene")</li>
<li>Реализовать ручную пагинацию для экрана поиска</li>
<li>Добавить возможность голосового набора в поле поиска</li>
<li>Добавить возможность сохранения изображений в избранное</li>
<li>Добавить возможность выбора одной из двух цветовых схем приложения</li>
<li>Добавить возможность включения-отключения звуковых и тактильных эффектов</li>
<li>Добавить обработку сценария отсутствия интернет-соединения</li>
<li>Использование векторных изображений в интерфейсе</li>
<li>Задокументировать код</li>
<li>Добавить тесты</li>
<li>Рефакторинг кода</li>
</details>
