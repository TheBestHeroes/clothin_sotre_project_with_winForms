
CREATE or REPLACE PROCEDURE add_person(
    p_username IN person.username%TYPE,
    p_password IN person.password%TYPE,
    p_full_name IN person.full_name%TYPE,
    p_email IN person.email%TYPE,
    p_phone IN person.phone%TYPE,
    p_gender IN person.gender%TYPE,
    p_is_active IN person.is_active%TYPE DEFAULT 1
)
AS
BEGIN
    INSERT INTO person (id,username,password,full_name,email,phone,gender,is_active)
    VALUES (person_seq.NEXTVAL,p_username,p_password,p_full_name,p_email,p_phone,p_gender,p_is_active);
END;
/


CREATE or REPLACE PROCEDURE add_invoice(
    p_employee_id IN invoice.employee_id%TYPE,
    p_customer_id IN invoice.customer_id%TYPE,
    p_invoice_date IN invoice.invoice_date%TYPE
)
AS
BEGIN
    INSERT INTO invoice (id,employee_id,customer_id,invoice_date)
    VALUES (invoice_seq.NEXTVAL,p_employee_id,p_customer_id,p_invoice_date);
END add_invoice;
/