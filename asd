from random import randint, choice


class User(object):
    def __init__(self):  # конструктор
        self.root = {"Файл 1": 0, "Файл 2": 0, "Файл 3": 0, "Файл 4": 0}

    # Юзлесс метод
    def stupidRandRoot(self):
        arr = [i for i in roots]
        for i in self.root:
            self.root[i] = choice(arr)

    def showRoots(self):
        k = 1
        for i in self.root:
            print(str(k) + "){:10}".format(i + ":"), "{:10}".format(roots[self.root[i]]))
            k += 1
        print(20 * "-")

    def takeNewRoot(self, filename="", newroot=""):  # принятие прав от другого пользователя
        newroot = getKey(roots, newroot)  # переходим на бинарку для лог.сложения прав
        if filename in self.root:  # проверяем нет ли ошибки в файле на который передают права
            self.root[filename] = self.root[filename] | newroot  # логическое сложение

    def giveRoot(self, filename, givenRoot):
        hisname = input("Кому передается право " + givenRoot + " на " + filename)
        for currentName in usernames:
            if hisname == currentName.lower():
                users[usernames[hisname]].root[filename] = users[usernames[hisname]].root[filename] | getKey(roots,
                                                                                                             givenRoot)

    def useFile(self):
        while True:
            action = input("Выберите действие(Чтение,Запись,Передача прав): ")
            flag = False
            for key in roots:
                if roots[key] == action:
                    flag = True
            if not flag:
                print("Ошибка действия с файлом,попробуйте еще раз.")
                pass
            else:
                break
        while True:
            file = input("Выберите файл - ")
            if file.isdigit():
                if int(file) > len(objects):
                    print("Неверно выбран файл.Попробуйте еще раз.")
                    pass
                else:
                    break
        if (getKey(roots, action) == self.root[objects[int(file)]]) or (self.root[objects[int(file)]] == 111):
            print("Успешно.")
        else:
            print("У вас недостаточно прав для " + action + " над", objects[int(file)])


usernames = {"Дарья": 0,
             "Азат": 1,
             "Дмитрий": 2,
             "Максим": 3,
             "Виктор": 4,
             "Вячеслав": 5,
             "Полина": 6,
             }
roots = {0: "Запрет",
         1: "Чтение",
         10: "Запись",
         11: "Чтение и Запись",
         100: "Передача прав",
         101: "Чтение - Передача прав",
         110: "Запись - Передача прав",
         1000: "Запись,Чтение - Передача прав",
         1001: "Чтение,Запись - Передача прав",
         111: "Полные права",
         }
users = [User() for i in usernames]  # Сделать себе админку
objects = ["Файл 1", "Файл 2", "Файл 3", "Файл 4"]


def login(logName, count=0):  # Функция для логина,3 попытки на вход, если Ошибка входа - прекращение программы
    for currentName in usernames:
        if logName == currentName.lower():
            print("Вход успешно выполнен.")
            return True
    if count < 2:
        logName = (str(input("Ошибка входа,попробуйте еще раз.\nИмя пользователя:"))).lower()
        login(logName, count + 1)
    else:
        print("Охрана за дверью.")
        return False


def getKey(dictionary, value):  # Возвращает ключ из словаря dictionary по значению value
    for item in dictionary:
        if dictionary[item] == value:
            return item


def susuTasks():  # рандом права и админку мне
    for index in usernames:  # случайные права ребяткам
        users[usernames[index]].stupidRandRoot()  # список объектов[получаем обычный индекс]
    for fileName in objects:  # админку мне
        users[usernames["Вячеслав"]].root[fileName] = 111
        users[usernames["Полина"]].root[fileName] = 111


def main():
    susuTasks()  # делаем ваши таски
    while True:  # для многократного использования программ
        command = (str(input(">>>"))).lower()  # регистры не важны
        if command == "вход":  # Команда для входа в систему
            name = str(input("Имя пользователя:")).lower()
            if login(name):  # False - вход не удался.True - вход выполнен
                command = (str(input(">>"))).lower()
                while True:  # для многократного использования в управление аккаунта
                    if command == "показать права":  # вывод на экран прав на опред.файл
                        users[usernames[name.capitalize()]].showRoots()
                        command = str(input(">")).lower()
                    elif command == "файлы":  # команда для работа с файлами
                        users[usernames[name.capitalize()]].useFile()
                        command = str(input(">")).lower()
                    if (command == "выход") or (command == "завершить"):  # выход из работы на аккаунтом
                        break
                    else:
                        pass
            else:
                break

        if command == "завершить":  # Выход из программы
            break


if __name__ == '__main__':
    main()
