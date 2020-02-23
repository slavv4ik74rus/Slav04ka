from random import randint, choice


class User(object):
    def __init__(self, filename="", newroot=0):
        self.root = {"CD-ROM": 0, "Дисковод": 0, "Файл 1": 0, "Файл 2": 0}
        if filename in self.root:
            self.root[filename] = self.root[filename] | newroot

    def showRoots(self):
        for i in self.root:
            print("{:10}".format(i + ":"), "{:10}".format(roots[self.root[i]]))
        print(20 * "-")

    def takeNewRoot(self, filename="", newroot=""):
        newroot = getKey(roots, newroot)
        if (filename in self.root) and newroot:
            self.root[filename] = self.root[filename] | newroot


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


def login(logName, count=0):  # Функция для логина,3 попытки на вход, если Ошибка входа - прекращение программы
    if logName in usernames and count < 2:
        print("Login successful.")
    elif count < 2:
        print("Login Error.Try again.")  # Сообщение при неверном Логине
        logName = str(input("Username:"))
        login(logName, count + 1)
    else:
        print("Охрана за дверью.")  # Сообщение после 3-х неудачных попыток входа
        return False
    return True


def getKey(dictionary, value):  # Возвращает ключ из словаря dictionary по значению value
    for item in dictionary:
        if dictionary[item] == value:
            return item



def main():
    while True:
        command = str(input(">>>"))
        if command == "login":  # Команда для входа в систему
            name = str(input("Username:"))
            if not login(name):  # False - вход не удался.True - вход выполнен
                break
            else:
                command = str(input(">>>"))
                while True:
                    if command == "Показать права":
                        users[usernames[name]].showRoots()
                        command = str(input(">>"))
                    #elif command ==
                    if command == ("logout"):
                        break
                    if command == "exit":
                        break
        if command == "exit":  # Выход из программы
            break


if __name__ == '__main__':
    main()

