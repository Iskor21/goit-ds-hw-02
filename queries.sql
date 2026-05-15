-- queries.sql

-- Отримати всі завдання певного користувача
SELECT * FROM tasks WHERE user_id = 1;

-- Вибрати завдання за певним статусом (приклад: 'new')
SELECT * FROM tasks WHERE status_id = 1;

-- Оновити статус конкретного завдання
UPDATE tasks SET status_id = 3 WHERE id = 11;

-- Отримати список користувачів, які не мають жодного завдання
SELECT * FROM users WHERE id NOT IN (
    SELECT DISTINCT user_id FROM tasks
);

-- Додати нове завдання для конкретного користувача
INSERT INTO tasks (user_id, title, status_id) VALUES ('1', 'додати запит', '1');

-- Отримати всі завдання, які ще не завершено
SELECT * FROM tasks WHERE status_id != 3;

-- Видалити конкретне завдання
DELETE FROM tasks WHERE id = 14;

-- Знайти користувачів з певною електронною поштою
SELECT * FROM users WHERE email LIKE '%@gmail.com%';

-- Оновити ім'я користувача
UPDATE users SET fullname = "Ira Ira" WHERE id = 1;

-- Отримати кількість завдань для кожного статусу
SELECT s.name AS status_name, COUNT(*) AS task_count
FROM tasks t
JOIN status s ON t.status_id = s.id
GROUP BY s.name;

-- Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти
SELECT t.id, t.title, u.email
FROM tasks t
JOIN users u ON t.user_id = u.id
WHERE u.email LIKE '%@example.net';

-- Отримати список завдань, що не мають опису
SELECT * FROM tasks WHERE description IS NULL OR description = '';

-- Вибрати користувачів та їхні завдання у статусі 'in progress'
SELECT u.id, u.fullname, t.title, s.name AS status_name
FROM users u
JOIN tasks t ON u.id = t.user_id
JOIN status s ON t.status_id = s.id
WHERE s.name = 'in progress';

-- Отримати користувачів та кількість їхніх завдань
SELECT u.id, u.fullname, COUNT(t.id) AS task_count
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id, u.fullname;
