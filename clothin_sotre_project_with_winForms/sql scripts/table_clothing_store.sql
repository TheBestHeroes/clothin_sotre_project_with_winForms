BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE person(
    id NUMBER(10) PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    password VARCHAR2(50) NOT NULL,
    phone VARCHAR2(13) UNIQUE,
    email VARCHAR2(50) UNIQUE,
    gender NUMBER(1),
    full_name NVARCHAR2(200),
    is_active NUMBER(1) DEFAULT 1 NOT NULL,
    is_deleted NUMBER(1) DEFAULT 0 NOT NULL
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/




BEGIN
   EXECUTE IMMEDIATE '
CREATE TABLE customer(
    id INT PRIMARY KEY,
    money NUMBER(20,4) NOT NULL,
    CONSTRAINT fk_customer_person FOREIGN KEY (id) REFERENCES person(id) 
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE '
CREATE TABLE manager(
    id int PRIMARY KEY,
    salary NUMBER(10,4),
    CONSTRAINT fk_manager_person FOREIGN KEY (id) REFERENCES person(id)
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE '
CREATE TABLE employee(
    id int PRIMARY KEY,
    salary NUMBER(10,4),
    managed_by INT NOT NULL,
    CONSTRAINT fk_employee_person FOREIGN KEY (id) REFERENCES person(id),
    CONSTRAINT fk_employee_manager FOREIGN KEY (managed_by) REFERENCES manager(id)
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE '
CREATE TABLE inventory(
    id INT PRIMARY KEY,
    quantity INT NOT NULL
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE '
CREATE TABLE invoice(
    id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    invoice_date DATE DEFAULT sysdate,
    CONSTRAINT fk_invoice_employee FOREIGN KEY (employee_id) REFERENCES employee(id),
    CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(id)

)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE product(
    id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    inventory_id INT NOT NULL,
    name NVARCHAR2(50) NOT NULL,
    color NVARCHAR2(15) NOT NULL,
    price NUMBER(10,2) NOT NULL DEFAULT 0,
    size NVARCHAR2(15),
    CONSTRAINT fk_product_employee FOREIGN KEY (employee_id) REFERENCES employee(id),
    CONSTRAINT fk_product_inventory FOREIGN KEY (inventory_id) REFERENCES inventory(id)
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE invoice_items(
    id INT PRIMARY KEY,
    invoice_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_inventoryItems_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    CONSTRAINT fk_inventoryItems_product FOREIGN KEY (product_id) REFERENCES product(id)
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE supplier(
    id INT PRIMARY KEY,
    manager_id INT,
    name NVARCHAR2(50) NOT NULL,
    phone NVARCHAR2(13) UNIQUE,
    CONSTRAINT fk_supplier_manager FOREIGN KEY (manager_id) REFERENCES manager(id)
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE supplier_addresses(
    id INT PRIMARY KEY,
    supplier_id INT NOT NULL,
    supplier_address NVARCHAR2(100) NOT NULL,
    CONSTRAINT fk_supplierAddresses_supplier FOREIGN KEY (supplier_id) REFERENCES supplier(id)
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN NULL; -- الجدول موجود مسبقًا
      ELSE RAISE;
      END IF;
END;
/


ALTER TABLE person
ADD CONSTRAINT chk_gender CHECK (gender IN (0,1));

ALTER TABLE customer
ADD CONSTRAINT chk_money CHECK (money >= 0);
