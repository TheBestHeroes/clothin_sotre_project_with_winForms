
CREATE TABLE person(
    id NUMBER(10) PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    password VARCHAR2(50) NOT NULL,
    phone VARCHAR2(13) UNIQUE,
    email VARCHAR2(50) UNIQUE,
    gender NUMBER(1),
    full_name NVARCHAR2(200),
    is_active NUMBER(1) DEFAULT 1 NOT NULL,
    is_deleted NUMBER(1) DEFAULT 0 NOT NULL,
    CONSTRAINT chk_gender CHECK (gender IN (0,1))
);


CREATE TABLE customer(
    id NUMBER(10) PRIMARY KEY,
    money NUMBER(20,4) NOT NULL,
    CONSTRAINT fk_customer_person FOREIGN KEY (id) REFERENCES person(id),
    CONSTRAINT chk_money CHECK (money >= 0)
);


CREATE TABLE manager(
    id NUMBER(10) PRIMARY KEY,
    salary NUMBER(10,4),
    CONSTRAINT fk_manager_person FOREIGN KEY (id) REFERENCES person(id)
);


CREATE TABLE employee(
    id NUMBER(10) PRIMARY KEY,
    salary NUMBER(10,4),
    managed_by NUMBER(10),
    CONSTRAINT fk_employee_person FOREIGN KEY (id) REFERENCES person(id),
    CONSTRAINT fk_employee_manager FOREIGN KEY (managed_by) REFERENCES manager(id)
);


CREATE TABLE inventory(
    id NUMBER(10) PRIMARY KEY,
    quantity NUMBER(10) NOT NULL
);


CREATE TABLE invoice(
    id NUMBER(10) PRIMARY KEY,
    employee_id NUMBER(10),
    customer_id NUMBER(10),
    invoice_date DATE DEFAULT sysdate,
    CONSTRAINT fk_invoice_employee FOREIGN KEY (employee_id) REFERENCES employee(id),
    CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(id)
);


CREATE TABLE products(
    id NUMBER(10) PRIMARY KEY,
    employee_id NUMBER(10),
    inventory_id NUMBER(10),
    name NVARCHAR2(50) NOT NULL,
    color NVARCHAR2(15) NOT NULL,
    price NUMBER(10,2) NOT NULL ,
    sized NVARCHAR2(15),
    CONSTRAINT fk_products_employee FOREIGN KEY (employee_id) REFERENCES employee(id),
    CONSTRAINT fk_products_inventory FOREIGN KEY (inventory_id) REFERENCES inventory(id)
);


CREATE TABLE invoice_items(
    id NUMBER(10) PRIMARY KEY,
    invoice_id NUMBER(10),
    products_id NUMBER(10),
    quantity NUMBER(10) NOT NULL,
    unit_price NUMBER(10,2),
    CONSTRAINT fk_inventoryItems_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    CONSTRAINT fk_inventoryItems_products FOREIGN KEY (products_id) REFERENCES products(id)
);


CREATE TABLE supplier(
    id NUMBER(10) PRIMARY KEY,
    manager_id NUMBER(10),
    name NVARCHAR2(50) NOT NULL,
    phone VARCHAR2(13) UNIQUE,
    CONSTRAINT fk_supplier_manager FOREIGN KEY (manager_id) REFERENCES manager(id)
);


CREATE TABLE supplier_addresses(
    id NUMBER(10) PRIMARY KEY,
    supplier_id NUMBER(10),
    supplier_address NVARCHAR2(100),
    CONSTRAINT fk_supplierAddresses_supplier FOREIGN KEY (supplier_id) REFERENCES supplier(id)
);
