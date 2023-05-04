/*

# Entregable 1

# Objetivo

> El alumno debera crear una base de datos enfocada en una API para una web de cursos
> 

<aside>
<img src="https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bac1d108-9af4-43da-a957-e7d338efe19f/icons8-pin-100.png" alt="https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bac1d108-9af4-43da-a957-e7d338efe19f/icons8-pin-100.png" width="40px" /> Es importante que valides el correcto funcionamiento de tu aplicación.
Debes de cumplir con los requerimientos indicados, las entregas y ten en cuenta las consideraciones listadas.
Así mismo aprovecha los recursos recomendados.

</aside>

## Instrucciones

1. Deberas crear las siguientes tablas y determinar su relacion, puedes agregar mas tablas en caso de ser necesario
    1. Users
    2. Courses
    3. Course Videos
    4. Categories
    5. Roles
2. Cada una de las tablas debera almacenar minimo, los siguientes datos:
    1. Users
        1. Name
        2. Email
        3. Password
        4. Age
    2. Courses
        1. Title
        2. Description
        3. Level (Si es para principiantes, medios o avanzados)
        4. Teacher
    3. Course Video
        1. Title
        2. Url
    4. Categories
        1. Name
    5. Roles
        1. Name (student, teacher, admin)
3. Deberan agregarles a las tablas sus respectivas relaciones y agregarles las llaves foraneas correspondientes
4. Exportaran a PostgreSQL
5. Y deberan de crear 2 registros de cada una de las tablas
6. Todos esos comandos agreguenlos a un archivo .sql incluyendo el que les generó dbdiagram para la creación de las tablas y subanlo a su class center desde un repositorio en github

## Rubrica

- Sintaxis
    - El codigo debe tener la sintaxis correcta
        
        20%
        
- Elementos
    - Debe contener los elementos para que su db funcione
        
        10%
        
- Funcionalidad
    - Al correr el archivo de comandos completo, no debe generar errores
        
        60%
        
- Codigo en ingles 10%

El alumno deberá crear una base de datos enfocada en una API para una web de cursos

<aside>
<img src="https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bac1d108-9af4-43da-a957-e7d338efe19f/icons8-pin-100.png" alt="https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bac1d108-9af4-43da-a957-e7d338efe19f/icons8-pin-100.png" width="40px" /> Es importante que valides el correcto funcionamiento de tu aplicación.
Debes de cumplir con los requerimientos indicados, las entregas y ten en cuenta las consideraciones listadas.
Así mismo aprovecha los recursos recomendados.

</aside>

## Instrucciones

1. Deberás crear las siguientes tablas y determinar su relación, puedes agregar mas tablas en caso de ser necesario.
    1. Users
    2. Courses
    3. Course Videos
    4. Categories
    5. Roles
2. Cada una de las tablas deberá almacenar minimo, los siguientes datos:
    1. Users
        1. Name
        2. Email
        3. Password
        4. Age
    2. Courses
        1. Title
        2. Description
        3. Level (Si es para principiantes, medios o avanzados)
        4. Teacher
    3. Course Video
        1. Title
        2. Url
    4. Categories
        1. Name
    5. Roles
        1. Name (student, teacher, admin)
3. Deberan agregarles a las tablas sus respectivas relaciones y agregarles las llaves foraneas correspondientes, poner las restricciones 
4. Exportaran a PostgreSQL
5. Y deberan de insertar minimo 2 registros en cada una de las tablas
6. Todos esos comandos agreguenlos a un archivo .sql incluyendo el que les generó dbdiagram para la creación de las tablas y subanlo a su class center desde un repositorio en github
7. Entretgar el link del repositorio de github y el link de dbdiagram

## Rubrica

- Sintaxis
    - El codigo debe tener la sintaxis correcta
        
        20%
        
- Elementos
    - Debe contener los elementos para que su db funcione
        
        10%
        
- Funcionalidad
    - Al correr el archivo de comandos completo, no debe generar errores
        
        60%
        
- Codigo en ingles 10%

*/


CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    role_id INT REFERENCES roles(id)
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    level VARCHAR(50) NOT NULL,
    teacher_id INT REFERENCES users(id)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE course_videos (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    url VARCHAR(2083) NOT NULL,
    course_id INT REFERENCES courses(id)
);

CREATE TABLE pivote_courses_categories (
    id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories(id),
    course_id INT REFERENCES courses(id),
    UNIQUE (category_id, course_id)
);

INSERT INTO roles (name) VALUES ('student'), ('teacher'), ('admin');

INSERT INTO users (name, email, password, age, role_id) VALUES
    ('John Doe', 'john.doe@example.com', 'password1', 25, (SELECT id FROM roles WHERE name = 'teacher')),
    ('Jane Smith', 'jane.smith@example.com', 'password2', 28, (SELECT id FROM roles WHERE name = 'student'));

INSERT INTO categories (name) VALUES ('Web Development'), ('Data Science');

INSERT INTO courses (title, description, level, teacher_id) VALUES
    ('Intro to Python', 'Learn the basics of Python programming', 'beginner', (SELECT id FROM users WHERE name = 'John Doe')),
    ('Advanced JavaScript', 'Master advanced JavaScript concepts', 'advanced', (SELECT id FROM users WHERE name = 'John Doe'));

INSERT INTO course_videos (title, url, course_id) VALUES
    ('Python Variables and Data Types', 'https://www.example.com/video1', (SELECT id FROM courses WHERE title = 'Intro to Python')),
    ('Python Functions and Modules', 'https://www.example.com/video2', (SELECT id FROM courses WHERE title = 'Intro to Python')),
    ('JavaScript Closures', 'https://www.example.com/video3', (SELECT id FROM courses WHERE title = 'Advanced JavaScript')),
    ('JavaScript Async and Await', 'https://www.example.com/video4', (SELECT id FROM courses WHERE title = 'Advanced JavaScript'));

INSERT INTO pivote_courses_categories (category_id, course_id) VALUES
    ((SELECT id FROM categories WHERE name = 'Web Development'), (SELECT id FROM courses WHERE title = 'Intro to Python')),
    ((SELECT id FROM categories WHERE name = 'Web Development'), (SELECT id FROM courses WHERE title = 'Advanced JavaScript')),
    ((SELECT id FROM categories WHERE name = 'Data Science'), (SELECT id FROM courses WHERE title = 'Intro to Python'));
