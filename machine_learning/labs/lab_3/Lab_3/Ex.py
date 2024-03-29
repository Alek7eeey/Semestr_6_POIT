# Ind_ID,GENDER,Car_Owner,Propert_Owner,CHILDREN,Annual_income,Type_Income,EDUCATION,Marital_status,Housing_type,Birthday_count,Employed_days,Mobile_phone,Work_Phone,Phone,EMAIL_ID,Type_Occupation,Family_Members

credit_card_csv = 'Credit_card.csv'
credit_card_label_csv = 'Credit_card_label.csv'

# 1. Выберите любой доступный на просторах интернета набор данных
# (dataset) подходящий для бинарной классификации.
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

table = pd.read_csv(credit_card_csv)
print(table.head())

labelTable = pd.read_csv(credit_card_label_csv)
print(labelTable.head())

# 2. Проанализируйте исходные данные, при необходимости заполните
# пропуски или удалить не важную информацию. Категориальные признаки
# замените на числовые

table = table.sort_values(by=['Ind_ID'])
labelTable = labelTable.sort_values(by=['Ind_ID'])

typesOfTypeIncome = table['Type_Income'].unique()
typesOfTypeIncome = {typesOfTypeIncome[i]: i for i in range(len(typesOfTypeIncome))}
table['Type_Income'] = table['Type_Income'].map(typesOfTypeIncome)
print(typesOfTypeIncome)

educationDictinary = {
    'Academic degree': 6,
    'Higher education': 5,
    'Incomplete higher': 4,
    'Secondary / secondary special': 1,
    'Lower secondary': 0,
}
table['EDUCATION'] = table['EDUCATION'].map(educationDictinary)
table['Type_Occupation'] = table['Type_Occupation'].apply(lambda x: 0 if pd.isna(x) else 1)
table['Annual_income'] = table['Annual_income'].apply(lambda x: 0 if pd.isna(x) else x)

# 3. Выделите из данных вектор меток У и матрицу признаков Х.
X = table[['Type_Occupation', 'Type_Income', 'Annual_income', 'CHILDREN', 'EDUCATION']]
Y = labelTable['label']

print(X.head()) #Выводятся первые пять строк DataFrame X.
# Это делается для проверки, что данные были корректно загружены и обработаны.

print(Y.head()) #Аналогично выводятся первые пять строк SeriesY.

# 4. Разделите набор данных на обучающую и тестовую выборки.
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier

X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.3, random_state=42)

print('X train | test:', X_train.shape, X_test.shape)
print('Y train | test:', Y_train.shape, Y_test.shape)

# 5. На обучающей выборке получите модели дерева решений и k-ближайших
# соседей, рассчитайте точность моделей.
decisionTree = DecisionTreeClassifier(random_state=0)
decisionTree.fit(X_train, Y_train)

xTrainScore = decisionTree.score(X_train, Y_train)
xTestScore = decisionTree.score(X_test, Y_test)

print('Правильность на обущающем наборе(дерево решений): ', xTrainScore)
print('Правильность на тестовом наборе(дерево решений): ', xTestScore)

knn = KNeighborsClassifier(n_neighbors=8)
knn.fit(X_train, Y_train)

xTrainScore = knn.score(X_train, Y_train)
xTestScore = knn.score(X_test, Y_test)

print('Правильность на обущающем наборе(knn): ', xTrainScore)
print('Правильность на тестовом наборе(knn): ', xTestScore)

# 6. Подберите наилучшие параметры моделей (например, глубину для дерева
# решений, количество соседей для алгоритма knn)

from sklearn.model_selection import GridSearchCV

parametrs = {'max_depth': range(1, 10)}
search = GridSearchCV(DecisionTreeClassifier(random_state=0), parametrs, cv=5)
search.fit(X_train, Y_train)

print('Лучшие параметры: ', search.best_params_)
print('Лучшая правильность: ', search.best_score_)

parametrs = {'n_neighbors': range(1, 10)}
search = GridSearchCV(KNeighborsClassifier(), parametrs, cv=5)
search.fit(X_train, Y_train)

print('Лучшие параметры: ', search.best_params_)
print('Лучшая правильность: ', search.best_score_)
input()

# 7. Рассчитайте матрицу ошибок (confusion matrix) для каждой модели.

from sklearn.metrics import confusion_matrix

print('DecisionTreeClassifier')
print(confusion_matrix(Y_test, decisionTree.predict(X_test)))
input();

print('KNeighborsClassifier')
print(confusion_matrix(Y_test, knn.predict(X_test)))
input();

# 8. Выберите лучшую модель.

best_model = decisionTree if xTestScore > xTrainScore else knn
print('Лучшая модель:', best_model)

# 9*. Визуализируйте полученную модель дерева решений (при визуализации
# желательно уменьшить глубину дерева, что бы рисунок был читаемым, или
# сохранить в отдельный файл)

from sklearn.tree import plot_tree

decreaseTree = DecisionTreeClassifier(max_depth=3, random_state=0)
decreaseTree.fit(X_train, Y_train)

plt.figure(figsize=(20, 20))
plot_tree(decreaseTree, filled=True, feature_names=list(X), class_names=['0', '1'])
plt.show()