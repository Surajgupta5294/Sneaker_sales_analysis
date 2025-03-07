select * from sneaker_sales.customers;
select * from sneaker_sales.products;
select * from sneaker_sales.sales;
select * from sneaker_sales.sales_reprentative;
select * from sneaker_sales.suppliers;


#  Objective (3) : "Supplier and Product Performance" :

# (1).What is the total sales amount for each supplier?
select  su.SupplierName, su.ContactPerson,sum(s.TotalAmount) as 'Total_sales'
  from sneaker_sales.sales s 
    inner join sneaker_sales.products p on s.ProductId = p.ProductId 
       inner join sneaker_sales.suppliers su on su.SupplierID = p.SupplierID 
         group by su.SupplierName,su.ContactPerson
           order by sum(TotalAmount) desc;


# (2).Which supplier has the highest average unit price for their products?
select s.ContactPerson, round(avg(p.UnitPrice)) as 'Average_unit_price'
  from sneaker_sales.products p 
   inner join sneaker_sales.suppliers s on p.SupplierID = s.SupplierID
     group by  s.ContactPerson
       order by Average_unit_price desc limit 1;


# (3).How many different products are provided by each supplier?
select p.Category, count(distinct p.ProductID) as 'product_count'
  from sneaker_sales.products p 
   inner join sneaker_sales.suppliers s on p.SupplierID = s.SupplierID
     group by  p.Category
	  order by count(p.ProductID);


# (4).What is the average total sales amount for products supplied by each supplier?
select  su.SupplierName, su.ContactPerson,round(avg(s.TotalAmount)) as 'Average_Total_sales'
  from sneaker_sales.sales s 
    inner join sneaker_sales.products p on s.ProductId = p.ProductId 
       inner join sneaker_sales.suppliers su on su.SupplierID = p.SupplierID 
         group by su.SupplierName,su.ContactPerson
           order by Average_Total_sales desc;



# (5).Which supplier's products have the highest total sales quantity?
select  su.SupplierName, su.ContactPerson,sum(s.Quantity) as 'Total_sales_Quantity'
  from sneaker_sales.sales s 
    inner join sneaker_sales.products p on s.ProductId = p.ProductId 
       inner join sneaker_sales.suppliers su on su.SupplierID = p.SupplierID 
         group by su.SupplierName,su.ContactPerson
           order by Total_sales_Quantity desc limit 1;



# (6).What is the most common category of products supplied by each supplier?
       select p.Category,sum(s.TotalAmount)
       from sneaker_sales.sales s 
       inner join sneaker_sales.products p on s.ProductID = p.ProductID
       inner join sneaker_sales.suppliers su on su.SupplierID =p.SupplierID
       group by p.Category
	   order by  sum(s.TotalAmount) limit 1;   
        
        
# (7).How does the performance of products from different suppliers compare?
select su.SupplierName,p.ProductName,sum(s.TotalAmount)
   from sneaker_sales.sales s 
	 inner join sneaker_sales.products p on s.ProductID = p.ProductID
	  inner join sneaker_sales.suppliers su on su.SupplierID =p.SupplierID
       group by su.SupplierName,p.ProductName
	    order by  sum(s.TotalAmount) desc; 

-- # (8).What is the distribution of product categories provided by each supplier?
select su.SupplierName,p.Category,
	sum(s.Quantity) as TotalQuantity
	 from sneaker_sales.sales s
      inner Join sneaker_sales.products p ON s.ProductID = p.ProductID
        inner join sneaker_sales.suppliers su ON su.SupplierID = p.SupplierID
         group by su.SupplierName, p.Category
          order by TotalQuantity desc;


# (9).How many products from each supplier are in the top 10 best-selling products?
select p.Category,s.SupplierName , count(distinct p.ProductID) as 'product_count'
  from sneaker_sales.products p 
   inner join sneaker_sales.suppliers s on p.SupplierID = s.SupplierID
     group by  p.Category,s.SupplierName
	  order by count(p.ProductID) desc limit 10;
      
      
WITH Top10Products AS (
    SELECT p.ProductID, p.ProductName, p.SupplierID, SUM(s.TotalAmount) AS TotalSales
    FROM sneaker_sales.sales s
    INNER JOIN sneaker_sales.products p ON s.ProductID = p.ProductID
    GROUP BY p.ProductID, p.ProductName, p.SupplierID
    ORDER BY TotalSales DESC
    LIMIT 10
)
SELECT su.SupplierName, COUNT(DISTINCT t.ProductID) AS ProductCount
FROM Top10Products t
INNER JOIN sneaker_sales.suppliers su ON t.SupplierID = su.SupplierID
GROUP BY su.SupplierName
ORDER BY ProductCount DESC;

# (10).What is the average sales amount per product category for each supplier?
select su.SupplierName,p.Category, 
  round(avg(s.TotalAmount)) as 'Average_sales_amount'
  from sneaker_sales.sales s 
   inner join sneaker_sales.products p on p.ProductID = s.ProductID
    inner join sneaker_sales.suppliers su on su.SupplierID = p.SupplierID
     group by  su.SupplierName, p.Category
	  order by Average_sales_amount desc;
 
