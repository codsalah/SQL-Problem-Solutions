CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) 
RETURNS INT AS $$
BEGIN
  IF N <= 0 THEN
    RETURN NULL;  
  END IF;
  RETURN (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    OFFSET N - 1 LIMIT 1
  );
END;
$$ LANGUAGE plpgsql;