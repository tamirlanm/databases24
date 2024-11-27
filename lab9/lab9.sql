--task1
create or replace function increase_value(input_value int)
returns int as $$
begin
    return input_value + 10;
end;
$$ language plpgsql;

--task2
create or replace procedure compare_numbers(
    a int,
    b int,
    out result text
)
language plpgsql as $$
begin
    if a > b then
        result := 'greater';
    elsif a = b then
        result := 'equal';
    else
        result := 'lesser';
    end if;
    return result;
end;
$$ language plpgsql;

--task3
create or replace procedure number_series(
    n int,
    out result text
)
language plpgsql as $$
declare
    i int;
    series text := '';
begin
    -- ensure n is valid
    if n <= 0 then
        raise exception 'The input number must be greater than 0.';
    end if;

    --Generate series using loop
    for i in 1..n loop
        series := series || i || ', ';
    end loop;
    --Remove the trailing comma and space
    result := rtrim(series, ', ');
end;
$$;

--task4
create or replace procedure find_employee(
    emp_name text,
    out emp_details text
)
language plpgsql as $$
begin
    --Fetch employee details
    select concat('Name: ', name, ', LastName: ', lastname, ', Department: ', department, ', city: ', city)
    into emp_details
    from employees
    whene name = emp_name;

    --Handle case when no employee is found
    if emp_details is null then
        emp_details := 'No employee found with the given name. ';
    end if;
end;
$$;

--task5
create or replace procedure list_products(
    category_name text
)
language plpgsql as $$
begin
    --Return a table of prod. det. filtered by the given category
    return query
    select id, name, price, category
    from products
    where category = category_name;
end;
$$

--task6
create or replace procedure calculate_bonus(
    emp_id int,
    out calculated_bonus numeric
)
language plpgsql as $$
declare
    emp_salary numeric;
begin
    --Fetch the employee's salary
    select salary into emp_salary from employees where id = emp_id;

    --Calculate the bonus as 10% of the salary
    calculated_bonus := emp_salary * 0.10;

    --Handle case where employee doesn't exist
    if not found then
        raise exception 'Employee with ID % not found.', emp_id;
    end if;
end;
$$;

create or replace procedure update_salary(emp_id int)
language plpgsql as $$
declare
    bonus numeric;
begin
    call calculate_bonus(emp_id,bonus);

    update employees
    set salary = salary + bonus,
    bonus = bonus
    where id = emp_id;

    if not found then
        raise exception 'Employee with ID % not found.', emp_id;
    end if;

    raise notice 'Salary updated for Employee ID %, bonus applied: %', emp_id, bonus;
end;
$$;

--task7
create or replace procedure complex_calculation(
    input_num integer,
    input_text varchar,
    out final_result varchar
) language plpgsql as $$
declare
    numeric_res integer;
    text_res varchar;
begin
    --Main block labeled as 'main_block'
    <<main_block>>
    begin
        -- First subblock: perform a numeric computation
        <<numeric_block>>
        begin
            numeric_result := input_num *2;
            raise notice 'Numeric result: %', numeric_res;
        end numeric_block;

        --Second subblock: perform a string manipulation
        <<string_block>>
        begin
            text_res := concat ('Hello, ', input_text);
            raise_notice 'Text result: %', text_res;
        end string_block;

        --Combine results
        final_result := concat(text_res, '- computed value: ', numeric_res);
        raise notice 'Final result: %', final_result;
    end main_block;
end;
$$;