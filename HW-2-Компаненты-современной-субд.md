### Возможных запросов\отчетов\поиска данных и индексы для них.
 ```
 - запросы по адресам, любые запросы связанные с джойнами адресной информации, название города, региона, страны
  Cities.country_name
  Regions.region_name
  Cities.city_name

 - запросы по производителям и поставщикам
  Manufactures.title
  Providers.title

 - запрсы по продуктам и категорийным свойствам (наверное больше всего поисков)
  Products.name
  Category_params.param_name
  Category_params.param_type
  Categories.category_name
 ```

### Логические ограничения в БД
```
Customers.birth_day - ограничить возраст от 18 до 80 на текущий день
Customers.marital_status - enum статусов
Customers.gender - enum статусов
Stock.count - больше 0
Sales.count - больше 0
все поля createdAt - сделать по умолчанию текущую дату
```