from random import randint, choice


class User(object):
    def __init__(self, filename="", newroot=0):
        self.root = {"CD-ROM": 1, "Дисковод": 0, "Файл 1": 0, "Файл 2": 0}
        if filename in self.root:
            self.root[filename] = self.root[filename] | newroot

    def showRoots(self):
        k = 0
        for i in self.root:
            print(str(k) + "){:10}".format(i + ":"), "{:10}".format(roots[self.root[i]]))
            k += 1
        print(20 * "-")

    def takeNewRoot(self, filename="", newroot=""):
        newroot = getKey(roots, newroot)
        if (filename in self.root) and newroot:
            self.root[filename] = self.root[filename] | newroot

    def useFile(self):
        action = input("Выберите действие")
        file = int(input("Выберите файл -"))
        if getKey(roots, action) == self.root[objects[file]]:
            print("Прочитано")


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
users = [User() for i in usernames]
objects = ["CD-ROM", "Дисковод", "Файл 1", "Файл 2"]


def login(logName, count=0):  # Функция для логина,3 попытки на вход, если Ошибка входа - прекращение программы
    for currentName in usernames:
        if logName == currentName.lower():
            print("Login successful.")
            return True
    if count < 2:
        logName = (str(input("Login Error.Try again.\nUsername:"))).lower()
        login(logName, count + 1)
    else:
        print("Охрана за дверью.")
        return False


def getKey(dictionary, value):  # Возвращает ключ из словаря dictionary по значению value
    for item in dictionary:
        if dictionary[item] == value:
            return item


def main():
    while True:
        command = (str(input(">>>"))).lower()
        if command == "login":  # Команда для входа в систему
            name = str(input("Username:")).lower()
            if login(name):  # False - вход не удался.True - вход выполнен
                command = (str(input(">>"))).lower()
                while True:
                    if command == "показать права":
                        users[usernames[name.capitalize()]].showRoots()
                        command = str(input(">")).lower()
                    if command == "usefile":
                        users[usernames[name.capitalize()]].useFile()
                        command = str(input(">")).lower()
                    """if command == "logout" or "exit":
                        break"""
            else:
                break

        if command == "exit":  # Выход из программы
            break


if __name__ == '__main__':
    main()
