## Тестовое задание Мараенко Александра на стажировку в Surf.ru

<img alt="github-banner" src="https://github.com/AAASASN/testTaskForSurf/blob/main/ImagesForReadme/topBanner-1.jpg?raw=true">

### Что нужно сделать?

Необходимо сверстать экран, чтобы он полностью повторял [дизайн](https://www.figma.com/file/S4ucVLUHYc0vLg2p1Xnart/IOS-%D1%81%D1%82%D0%B0%D0%B6%D0%B8%D1%80%D0%BE%D0%B2%D0%BA%D0%B0?node-id=45%3A77&t=N4eUtEGJu7LxSAnC-1). 

<img alt="github-banner" src="https://github.com/AAASASN/testTaskForSurf/blob/main/ImagesForReadme/Figma.jpg?raw=true">

Помимо верстки на UIKit, нет никаких ограничений в выборе способов реализации данной задачи. 

### Решение

- Для возможности скрола экрана использован ViewController который появляется модально поверх основного. Для удержания в трех положениях применен метод sheetPresentationControllerDidChangeSelectedDetentIdentifier протокола UISheetPresentationControllerDelegate;
- При нижнем положении контроллера нижняя карусел и ее лейбл изчезают;
- Экран сверстан в коде на констрейнтах;
- Карусели реализованы на CollectionView, скролятся в право и в лево, но не бесконечно;
- При нажати ячейки выделяются черным цветом, при повторном нажатии выделение пропадает;
- В верхней карусели при нажатии на ячейку она перемещается влево - в начало очереди.
#

![gif](https://github.com/AAASASN/testTaskForSurf/blob/main/ImagesForReadme/Simulator%20Screen%20Recording%20-%20iPhone%2014%20-%201.gif)
![gif](https://github.com/AAASASN/testTaskForSurf/blob/main/ImagesForReadme/Simulator%20Screen%20Recording%20-%20iPhone%2014%20-%202.gif)
![gif](https://github.com/AAASASN/testTaskForSurf/blob/main/ImagesForReadme/Simulator%20Screen%20Recording%20-%20iPhone%2014%20-%203.gif)
![gif](https://github.com/AAASASN/testTaskForSurf/blob/main/ImagesForReadme/Simulator%20Screen%20Recording%20-%20iPhone%2014%20-%203.gif)


### Работы ведутся

- Бесконечная карусель для нижнего CollectionView;
- Градиент для нижнего вью на котором расположен лейбл и кнопка "Отправить заявку". Что бы контент контроллера пострепенно скрывался за градиентом при прокручивании вниз.
