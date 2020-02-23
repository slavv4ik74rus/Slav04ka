from random import randint, choice

users = ["Дарья", "Азат", "Дмитрий", "Максим", "Виктор", "Вячеслав", "Полина", ]
usersRoots = ["Заперт", "Чтение", "Запись", "Передача прав"]                #ВООООООООООООООООООООТ ЗДЕЕЕЕЕЕЕЕСЬ
objects = ["CD-ROM", "Дисковод"]


class Roots(object):
    def __init__(self):
        self.roots = [choice(usersRoots) for i in range(randint(1, 3))]         #ВООООООООООООООООООООООООООТ ЗДЕСЬ
        self.name = users[countUsers]

    def showRoots(self):
        print(self.name+":")
        for nameObj in objects:
            print("{:15}".format(nameObj), end="-")
            for root in self.roots:
                print("{:15}".format(root+"|"))
            print()


def login(name, count=0):  # Функция для логина,3 попытки на вход, если Ошибка входа - прекращение программы
    if name in users and count < 2:
        print("Login successful.")
    elif count < 2:
        print("Login Error.Try again.")  # Сообщение при неверном Логине
        name = str(input("Username:"))
        login(name, count + 1)
    else:
        print("Охрана за дверью.")  # Сообщение после 3-х неудачных попыток входа
        return False
    return True


if __name__ == '__main__':
    while True:
        command = str(input(">>>"))
        if command == "login":  # Команда для входа в систему
            name = str(input("Username:"))
            if not login(name):  # False - вход не удался.True - вход выполнен
                break
            else:
                countUsers = users.index(name)
                user = Roots()
                Roots.showRoots(user)
        if command == "exit":  # Выход из программы
            break
