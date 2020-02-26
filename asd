from random import choice


class User(object):
    def __init__(self):  # конструктор
        arr = [i for i in roots]
        self.root = {key: choice(arr) for key in objects}
        arr.clear()

    def showRoots(self):
        k = 1
        for file in objects:
            print(str(k) + "){:10}".format(file + ":") + "{:10}".format(roots[self.root[file]]))
            k += 1
        print(30 * "*")

    def giveRoot(self):
        while True:
            filename = input("На какой файл передаются права: ").lower()
            if filename.isdigit():
                if (0 > int(filename)) or (int(filename) > len(objects)) or (not int(filename)):
                    print("Неверно выбран файл.Попробуйте ещё раз.")
                    continue
                else:
                    filename = int(filename) - 1
            filename = objects[int(filename)]# if filename.isdigit() else filename
            if isInclude(objects, filename):
                break
            else:
                print("Ошибка ввода данных.Попробуйте еще раз.")
        while True:
            root = input("Какое право передается(Чтение,Запись): ")
            if isInclude(roots, root, 1):
                root = getKey(roots, root)
                break
            else:
                print("Ошибка ввода данных.Попробуйте еще раз.")
        while True:
            name = input("Кому вы хотите это передать: ")
            if isInclude(usernames, name):
                name = usernames.index(name.lower())
                break
            else:
                print("Ошибка ввода данных.Попробуйте еще раз.")
        if (self.root[filename] > 100) or (self.root[filename] == root):
            users[name].root[filename] = users[name].root[filename] | root
        #users[usernames.index("азат")].showRoots()  # DEBUG


usernames = ["дарья",
             "азат",
             "дмитрий",
             "максим",
             "виктор",
             "вячеслав",
             "полина",
             ]
roots = {0: "Запрет",
         1: "Чтение",
         10: "Запись",
         11: "Чтение и Запись",
         101: "Чтение - Передача прав",
         110: "Запись - Передача прав",
         1000: "Запись,Чтение - Передача прав",
         1001: "Чтение,Запись - Передача прав",
         111: "Полные права",
         }
objects = ["файл 1", "файл 2", "файл 3", "файл 4"]
users = [User() for i in usernames]


# подумать
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
    if len(dictionary) > 0:
        for item in dictionary:
            if dictionary[item] == value:
                return item
    return None


def isInclude(array, value, dictvalue=0):  # Проверяем есть ли элемент в списке или элемент из словаря
    if dictvalue:
        for element in array:
            if array[element] == value:
                return True
    else:
        for element in array:
            if element == value:
                return True
    return False


def adminsRoots():  # рандом права и админку мне
    for fileName in objects:  # админку мне
        users[usernames.index("вячеслав")].root[fileName] = 111  # Админку мне
        users[usernames.index("полина")].root[fileName] = 111  # И моему другу
        users[usernames.index("дарья")].root[fileName] = 0  # А ей запретиков для тестов


def main():
    adminsRoots()  # Админки и Одному челику все запреты для тестов
    while True:
        command = (str(input(">>>"))).lower()
        if command == "вход":  # Команда для входа в систему
            name = str(input("Имя пользователя:")).lower()
            if login(name):
                while True:
                    command = (str(input(">>"))).lower()
                    if command == "показать права":
                        users[usernames.index(name.lower())].showRoots()
                        command = str(input(">")).lower()
                    if command == "передать право":
                        users[usernames.index(name.lower())].giveRoot()
                        command = str(input(">")).lower()
                    if (command == "выход") or (command == "завершить"):
                        break
            else:
                break
        if command == "завершить":  # Выход из программы
            break


if __name__ == '__main__':
    main()
