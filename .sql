-- USERS TABLE
CREATE TABLE Users ( 
    user_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100), 
    email VARCHAR(100) UNIQUE NOT NULL, 
    password_hash VARCHAR(255) NOT NULL, 
    phone_number VARCHAR(20), 
    address TEXT, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- CATEGORIES TABLE
CREATE TABLE Categories ( 
    category_id INT AUTO_INCREMENT PRIMARY KEY, 
    category_name VARCHAR(100) NOT NULL
    -- UNIQUE(category_name) -- optional: if you want category names to be unique
); 

-- PRODUCTS TABLE
CREATE TABLE Products ( 
    product_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    description TEXT, 
    price DECIMAL(10, 2) NOT NULL, 
    stock_quantity INT DEFAULT 0, 
    category_id INT, 
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
    -- ON DELETE SET NULL -- optional
); 

-- CART TABLE
CREATE TABLE Cart ( 
    cart_id INT AUTO_INCREMENT PRIMARY KEY, 
    user_id INT, 
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
    -- UNIQUE(user_id) -- optional: if 1 cart per user only
); 

-- CARTITEMS TABLE
CREATE TABLE CartItems ( 
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY, 
    cart_id INT, 
    product_id INT, 
    quantity INT NOT NULL, 
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id), 
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    UNIQUE(cart_id, product_id) -- prevents duplicate entries for the same product in a cart
); 

-- ORDERS TABLE
CREATE TABLE Orders ( 
    order_id INT AUTO_INCREMENT PRIMARY KEY, 
    user_id INT, 
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    status VARCHAR(50) DEFAULT 'pending', 
    total_amount DECIMAL(10, 2), 
    shipping_address TEXT, 
    FOREIGN KEY (user_id) REFERENCES Users(user_id) 
); 

-- ORDERITEMS TABLE
CREATE TABLE OrderItems ( 
    order_item_id INT AUTO_INCREMENT PRIMARY KEY, 
    order_id INT, 
    product_id INT, 
    quantity INT NOT NULL, 
    price_at_purchase DECIMAL(10, 2), 
    FOREIGN KEY (order_id) REFERENCES Orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    UNIQUE(order_id, product_id) -- optional
); 

-- PAYMENTS TABLE
CREATE TABLE Payments ( 
    payment_id INT AUTO_INCREMENT PRIMARY KEY, 
    order_id INT NOT NULL, 
    payment_method VARCHAR(50) NOT NULL, 
    payment_status VARCHAR(50) DEFAULT 'completed', 
    amount_paid DECIMAL(10, 2) NOT NULL, 
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) 
);
