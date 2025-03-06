select * from sneaker_sales.customers;
select * from sneaker_sales.products;
select * from sneaker_sales.sales;
select * from sneaker_sales.sales_reprentative;
select * from sneaker_sales.suppliers;


#  Objective (2) : "Customer and Product Analysis"s

# (1).What is the average spending per customer?
select  t2.CustomerID ,round( avg(TotalAmount)) as 'Average_spending' 
    from sneaker_sales.sales t1 
       inner join sneaker_sales.customers t2 on t1.CustomerID = t2.CustomerID
           group by t2.CustomerID
               order by  Average_spending desc;

select  CustomerID ,round( avg(TotalAmount)) as 'Average_spending' 
    from sneaker_sales.sales 
           group by CustomerID
               order by  Average_spending desc;

      
# (2).Which product is the most frequently purchased by customers?
select t2.ProductName, count(t1.ProductID ) as 'purchased_by_customers'
    from sneaker_sales.sales t1 
      inner join sneaker_sales.products t2 on t1.ProductID = t2.ProductID
        group by t2.ProductName
          order by purchased_by_customers desc
             limit 1;
          
 
         # (3).How many unique customers made purchases in each city?
select  t2.city ,count(distinct(t1.CustomerID)) as 'Unique_Customer'
    from sneaker_sales.sales t1  
     inner join sneaker_sales.customers t2 on t1.CustomerID = t2.CustomerID
      group by t2.city
        order by Unique_Customer desc;
        
select  city ,count(distinct(CustomerID)) as 'Unique_Customer'
    from sneaker_sales.customers
     group by city
        order by Unique_Customer desc;


# (4).What is the distribution of product categories purchased by customers?
select t2.Category, sum(TotalAmount) as 'purchased_by_customers'
    from sneaker_sales.sales t1 
      inner join sneaker_sales.products t2 on t1.ProductID = t2.ProductID
        group by t2.Category
          order by purchased_by_customers desc;
          
       
          
# (5).How many repeat customers are there in the dataset?
select C.FirstName,C.LastName ,count(S.CustomerID)  as 'repeat_customer'
    from sneaker_sales.sales S 
      inner join sneaker_sales.customers C on S.CustomerID = C.CustomerID
        group by C.FirstName,C.LastName , C.CustomerID
		 HAVING COUNT(S.CustomerID) > 1
          order by repeat_customer;


# (6).What is the average unit price of products purchased by customers?
select round(avg(UnitPrice)) as 'Average'
  from sneaker_sales.products P 
   inner join sneaker_sales.sales S on P.ProductID = S.ProductID ;


# (7).How does the spending behavior differ between customers from different states?
select  c.State, c.FirstName,c.LastName,
  sum(s.TotalAmount) as 'Spending'
   from sneaker_sales.sales s 
      inner join sneaker_sales.customers c on s.CustomerID = c.CustomerID
        group by  c.State,c.FirstName,c.LastName 
          order by Spending desc;
      


# (8).Which supplier provides the most popular products?
select s.ContactPerson ,p.ProductName, sum(SA.TotalAmount) as 'Most_popular'
   from sneaker_sales.suppliers s
     inner join sneaker_sales.products p on s.SupplierID = p.SupplierID
        inner join sneaker_sales.sales SA on SA.ProductID = p.ProductID
          group by s.ContactPerson ,p.ProductName
           order by Most_popular desc 
            limit 5 ;


# (9).What is the most common product category purchased by customers?
select p.Category,sum(s.TotalAmount)
  from sneaker_sales.sales s 
    inner join sneaker_sales.products p on s.ProductID = p.ProductID
      group by p.Category
        order by  sum(s.TotalAmount) limit 1;                                     
        

# (10).How many customers purchased more than one type of product?
select p.ProductName,sum(s.TotalAmount) ,count(distinct s.CustomerID)
  from sneaker_sales.sales s 
    inner join sneaker_sales.products p on s.ProductID = p.ProductID
      group by p.ProductName ,s.CustomerID
        order by sum(s.TotalAmount) desc limit 5;           

SELECT COUNT(DISTINCT s.CustomerID) AS CustomersWithMultipleProducts
FROM sneaker_sales.sales s
INNER JOIN sneaker_sales.products p 
    ON s.ProductID = p.ProductID
GROUP BY s.CustomerID
HAVING COUNT(DISTINCT p.ProductID) > 1;


