# 1. Выявите пропуски данных несколькими способами (визуальный,
# расчетный…)
# При удалении (замене) пропусков необходимо рассуждать: можно ли
# удалить данный параметр и чем целесообразно заменять пропуски данных
# в конкретных параметрах, руководствуясь описанием параметров
# датасета и предметной областью.
# 2. Исключите строки и столбцы с наибольшим количеством пропусков.
# 3. Произведите замену оставшихся пропусков на логически обоснованные
# значения.
# 4. Постройте гистограмму распределения исходного датасета до и после
# обработки пропусков. Сделайте выводы как обработка данных повлияла
# на их распределение.
# 5. Проверьте датасет на наличие выбросов, удалите найденные аномальные
# записи.
# 6. Приведите все параметры к числовому виду (кодирование текстовых
# данных).
# 7. Сохраните обработанный датасет

# Dataset 'autoscout24-germany-dataset.csv'
# mileage,make,model,fuel,gear,offerType,price,hp,year
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Загрузка данных
df = pd.read_csv('D:\\studing\\6_semestr\\machine_learning\\labs\\lab_2\\germany-dataset.csv')

# 1. Выявим пропуски данных
print('Пропуски данных (визуальный способ):')
cols = df.columns[:]

# определяем цвета
# красный - пропущенные данные
colours = ['#eeeeee', '#ff0000']
sns.heatmap(df[cols].isnull(), cmap=sns.color_palette(colours))
print('Пропуски данных (расчетный способ):')
print(df.isnull().sum())

# 2. Удалим строки и столбцы с наибольшим количеством пропусков
threshold = 0.5  # Пороговое значение для удаления
plt.figure(figsize=(12, 6))
plt.subplot(2, 2, 1)
plt.title('Гистограмма "mileage" до обработки')
plt.hist(df['mileage'], bins=20, alpha=0.7, color='blue')
plt.subplot(2, 2, 3)
plt.title('Гистограмма "price" до обработки')
plt.hist(df['price'], bins=20, alpha=0.7, color='blue')
df = df.dropna(axis=1, thresh=threshold * len(df))  # Удаление столбцов
df = df.dropna(axis=0, thresh=threshold * len(df.columns))  # Удаление строк

# 3. Замена пропусков на логически обоснованные значения
# Замена в числовых столбцах на среднее значение
numeric_cols = df.select_dtypes(include=[np.number]).columns
df[numeric_cols] = df[numeric_cols].fillna(df[numeric_cols].mean())

# 4. Построим гистограммы до и после обработки пропусков
plt.subplot(2, 2, 2)
plt.title('Гистограмма "mileage" после обработки')
plt.hist(df['mileage'], bins=20, alpha=0.7, color='green')
plt.subplot(2, 2, 4)
plt.title('Гистограмма "price" после обработки')
plt.hist(df['price'], bins=20, alpha=0.7, color='green')
plt.tight_layout()
plt.show()

# 5. Проверим наличие выбросов и удалим аномальные записи
# Для примера, проверим 'mileage' на выбросы
sns.boxplot(x=df['mileage'])
# Определим границы выбросов
Q1 = df['mileage'].quantile(0.25)
Q3 = df['mileage'].quantile(0.75)
IQR = Q3 - Q1
lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
# Удаление выбросов
df = df[(df['mileage'] >= lower_bound) & (df['mileage'] <= upper_bound)]

# 6. Приведем все параметры к числовому виду
# Для этого заменим категориальные данные на числовые
categorical_cols = ['make', 'model', 'fuel', 'gear', 'offerType']
for col in categorical_cols:
    if col in df.columns:
        df[col] = df[col].astype('category').cat.codes

# 7. Сохраним обработанный датасет
df.to_csv('processed_autoscout24_data.csv', index=False)
