-- Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table

select p.product_name, s.company_name, c.category_name 
    from products p
join suppliers s on p.supplier_id = s.supplier_id 
join categories c on c.category_id = p.category_id;