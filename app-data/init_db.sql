CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    telegram_id BIGINT UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    registration_date TIMESTAMP WITH TIME ZONE
);

CREATE TABLE categories (
    id_category SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE brands (
    id_brand SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    id_product SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    weight_grams NUMERIC(8, 2),
    stock INTEGER NOT NULL,
    id_category INTEGER REFERENCES categories(id_category),
    id_brand INTEGER REFERENCES brands(id_brand)
);

CREATE TABLE interactions (
    id_interaction SERIAL PRIMARY KEY,
    id_user INTEGER NOT NULL REFERENCES users(id_user), 
    user_question TEXT NOT NULL, 
    bot_response TEXT,
    question_date TIMESTAMP WITH TIME ZONE 
);


INSERT INTO categories (name) VALUES
('Smartphones'),
('Laptops'),
('Accesorios'),
('Audio y Sonido'),
('Wearables');

INSERT INTO brands (name) VALUES
('Samsung'),
('Apple'),
('Sony'),
('Dell'),
('Xiaomi'),
('JBL'),
('Logitech'),
('HP'),
('Garmin'),
('Bose');

INSERT INTO products (name, description, price, weight_grams, stock, id_category, id_brand) VALUES
('Galaxy S23 Ultra', 'Teléfono de gama alta con S Pen y cámara de 200MP.', 1299.99, 234.00, 150, 1, 1),
('iPhone 15 Pro', 'Flagship de Apple con chip A17 Bionic y cuerpo de titanio.', 1199.00, 187.00, 120, 1, 2),
('Xiaomi 13T Pro', 'Alto rendimiento con carga ultra rápida y pantalla AMOLED.', 899.50, 200.00, 90, 1, 5),
('Xperia 5 V', 'Smartphone compacto con enfoque en fotografía y batería.', 949.00, 182.00, 65, 1, 3),
('iPhone SE 3ra Gen', 'Modelo económico de Apple con chip A15.', 429.00, 144.00, 300, 1, 2),
('Galaxy A54', 'Gama media popular con excelente pantalla y resistencia al agua.', 499.00, 202.00, 450, 1, 1),
('Redmi Note 12 Pro', 'Teléfono equilibrado con cámara de 108MP.', 349.99, 187.00, 500, 1, 5),
('iPhone 14 Plus', 'Batería de larga duración y pantalla grande.', 999.00, 203.00, 80, 1, 2),
('Galaxy Z Flip 4', 'Smartphone plegable de diseño compacto.', 799.00, 183.00, 40, 1, 1),
('Poco F5', 'Potente gama media/alta enfocado en juegos.', 379.00, 181.00, 210, 1, 5),

('MacBook Pro M3 Max 16"', 'Máximo rendimiento para profesionales creativos.', 3499.00, 2150.00, 30, 2, 2),
('Dell XPS 13 Plus', 'Laptop premium con diseño minimalista y pantalla OLED.', 1799.00, 1260.00, 55, 2, 4),
('HP Spectre x360', 'Convertible 2 en 1 con pantalla táctil y pluma.', 1499.99, 1360.00, 70, 2, 8),
('MacBook Air M2 13"', 'Ultraligera y eficiente, ideal para portabilidad.', 1099.00, 1240.00, 180, 2, 2),
('Dell Inspiron 15', 'Laptop de uso general, buen rendimiento diario.', 649.00, 1850.00, 250, 2, 4),
('HP Pavilion Gaming 15', 'Laptop para juegos con tarjeta gráfica dedicada.', 899.00, 2250.00, 95, 2, 8),
('MacBook Pro M2 14"', 'Equilibrio entre potencia y portabilidad.', 1999.00, 1600.00, 60, 2, 2),
('Xiaomi Mi Notebook Pro', 'Diseño delgado y excelente relación calidad-precio.', 999.00, 1400.00, 45, 2, 5),
('Dell Latitude 5430', 'Laptop empresarial con funciones de seguridad.', 1150.00, 1490.00, 80, 2, 4),
('HP Envy x360', 'Laptop convertible versátil para estudiantes.', 799.00, 1550.00, 110, 2, 8),
('Dell G15 Gaming', 'Laptop para juegos robusta y potente.', 1099.00, 2810.00, 75, 2, 4),
('Mac Mini M2', 'Computadora de escritorio compacta y potente.', 599.00, 1200.00, 100, 2, 2),
('HP 14-dq0053dx', 'Laptop básica para tareas de oficina.', 399.00, 1470.00, 320, 2, 8),
('Dell Alienware M16', 'Laptop gaming de alta gama.', 2499.00, 2500.00, 20, 2, 4),
('Xiaomi RedmiBook 15', 'Laptop económica para trabajo ligero.', 499.00, 1800.00, 150, 2, 5),

('Logitech MX Master 3S', 'Mouse inalámbrico ergonómico de alto rendimiento.', 99.99, 141.00, 250, 3, 7),
('Apple AirTag (4-Pack)', 'Rastreadores de objetos con precisión.', 99.00, 45.00, 500, 3, 2),
('HP X3000 Ratón Inalámbrico', 'Mouse óptico básico y confiable.', 19.99, 100.00, 800, 3, 8),
('Logitech K380', 'Teclado multi-dispositivo Bluetooth compacto.', 39.99, 423.00, 300, 3, 7),
('Samsung T7 Shield SSD 1TB', 'Disco sólido portátil USB 3.2 resistente.', 129.00, 98.00, 150, 3, 1),
('Cable Thunderbolt 4', 'Cable de alta velocidad y transferencia de datos.', 69.00, 50.00, 120, 3, 2),
('Logitech C920S Pro HD', 'Webcam Full HD 1080p para videollamadas.', 79.99, 162.00, 180, 3, 7),
('Xiaomi Mi Power Bank 3 Pro 20000mAh', 'Batería externa de alta capacidad y carga rápida.', 49.00, 440.00, 400, 3, 5),
('HP 27er Monitor Full HD', 'Monitor de 27 pulgadas con diseño delgado.', 199.00, 4000.00, 90, 3, 8),
('Logitech G Pro X Superlight', 'Mouse gaming ultraligero para eSports.', 139.00, 63.00, 110, 3, 7),

('Sony WH-1000XM5', 'Audífonos con cancelación de ruido líder en la industria.', 399.99, 250.00, 200, 4, 3),
('AirPods Pro 2da Gen', 'Auriculares TWS con cancelación y audio espacial.', 249.00, 50.00, 400, 4, 2),
('JBL Flip 6', 'Bocina Bluetooth portátil, resistente al agua.', 129.00, 550.00, 350, 4, 6),
('Bose QuietComfort Earbuds II', 'Auriculares inalámbricos de alta fidelidad.', 299.00, 60.00, 180, 4, 10),
('Sony WF-C700N', 'Auriculares True Wireless con ANC, compactos y ligeros.', 119.99, 45.00, 280, 4, 3),
('JBL Charge 5', 'Bocina con gran autonomía y función powerbank.', 179.99, 960.00, 220, 4, 6),
('Samsung Galaxy Buds2 Pro', 'Auriculares de Samsung con audio Hi-Fi.', 229.00, 55.00, 160, 4, 1),
('Bose SoundLink Micro', 'Bocina ultra portátil, ideal para exteriores.', 99.00, 290.00, 300, 4, 10),
('Sony SRS-XB13', 'Bocina compacta y potente con bajos profundos.', 59.99, 253.00, 410, 4, 3),
('JBL GO 3', 'Bocina más pequeña de JBL, ultra portátil.', 49.99, 209.00, 550, 4, 6),
('Xiaomi Buds 4 Pro', 'Auriculares con buen audio y diseño ergonómico.', 149.00, 50.00, 120, 4, 5),
('Sony HT-A9', 'Sistema de cine en casa inalámbrico avanzado.', 1999.00, 1800.00, 15, 4, 3),
('JBL PartyBox 310', 'Bocina de fiesta con luces y batería.', 499.00, 17400.00, 50, 4, 6),
('Bose Sport Earbuds', 'Auriculares resistentes al sudor para deportes.', 179.00, 65.00, 140, 4, 10),
('Samsung Soundbar Q990C', 'Barra de sonido de 11.1.4 canales con Dolby Atmos.', 1499.00, 18000.00, 25, 4, 1),

('Apple Watch Series 9', 'Smartwatch con detección de caídas y monitor de oxígeno.', 399.00, 42.00, 190, 5, 2),
('Garmin Fenix 7 Pro', 'Reloj multideporte con GPS y carga solar.', 799.00, 73.00, 85, 5, 9),
('Samsung Galaxy Watch 6', 'Reloj inteligente con análisis de composición corporal.', 299.00, 33.00, 160, 5, 1),
('Xiaomi Band 7 Pro', 'Pulsera de actividad con GPS integrado y pantalla AMOLED.', 89.00, 20.00, 350, 5, 5),
('Garmin Venu 2 Plus', 'Smartwatch con micrófono y altavoz.', 449.00, 49.00, 70, 5, 9);
