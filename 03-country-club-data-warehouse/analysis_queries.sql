USE cc;

Select * From dining
order by Member_Number;
Select * From golf;
Select * From members;
Select * From memberships;
Select * From other;
Select * From pool;
Select * From promoone;
Select * From promotwo;
Select * From special;
Select * From tennis;

Select Member_Number, Count(BirthDate) AS Number_of_member 
From members
group by Member_Number;

Create Table c as (
Select 
	m.Member_Number,
	m.Number_of_member, 
    COALESCE(d.Total_Dining_spending, 0) AS Total_Dining_spending,
    Latest_dining_Date,
    COALESCE(g.Total_Golf_spending, 0) AS Total_Golf_spending,
    Latest_golf_Date,
    COALESCE(p.Total_Pool_spending, 0) AS Total_Pool_spending,
    Latest_pool_Date,
    COALESCE(t.Total_Tennis_spending, 0) AS Total_Tennis_spending,
    Latest_tennis_Date,
    COALESCE(o.Total_Other_spending, 0) AS Total_Other_spending,
	(COALESCE(d.Total_Dining_spending, 0) + 
     COALESCE(g.Total_Golf_spending, 0) + 
     COALESCE(p.Total_Pool_spending, 0) + 
     COALESCE(o.Total_Other_spending, 0)) AS Total_Spending,
     CASE WHEN p1.Member_Number IS NOT NULL THEN 1 ELSE 0 END AS Participated_Promo1,
	 CASE WHEN p2.Member_Number IS NOT NULL THEN 1 ELSE 0 END AS Participated_Promo2
From ( Select Member_Number, Count(BirthDate) AS Number_of_member
		From members
		group by Member_Number) m
left join ( Select Member_Number, sum(Total) AS Total_Dining_spending, MAX(Date) AS Latest_dining_Date
			From dining
			group by Member_Number) d
on m.Member_Number = d.Member_Number
left join (Select Member_Number, sum(Amount) AS Total_Golf_spending,MAX(Date) AS Latest_golf_Date
			From golf
			group by Member_Number) g
on m.Member_Number = g.Member_Number
left join ( Select Member_Number, sum(Amount) AS Total_Other_spending
			From other
			group by Member_Number) o
on m.Member_Number = o.Member_Number
left join ( Select Member_Number, sum(Amount) AS Total_Pool_spending,MAX(Date) AS Latest_pool_Date
			From pool
			group by Member_Number) p
on m.Member_Number = p.Member_Number
left join ( Select Member_Number, sum(Amount) AS Total_Tennis_spending,MAX(Date) AS Latest_tennis_Date
	From tennis
	group by Member_Number) t
on m.Member_Number = t.Member_Number
left join promoone p1
on m.Member_Number = p1.Member_Number
left join promotwo p2
on m.Member_Number = p2.Member_Number
Order by m.Member_Number)
;


Select Sum(Total_Dining_spending),
		sum(Total_Golf_spending),
        sum(Total_Pool_spending),
        sum(Total_Tennis_spending),
        sum(Total_Other_spending)
From c ;

SELECT *
FROM c
WHERE Total_Spending > 15000
ORDER BY Total_Spending DESC;

SELECT *
FROM c;

SELECT 
    Member_Number,
    Total_Dining_spending,
    Total_Golf_spending
FROM c
WHERE Total_Dining_spending > 5000 AND Total_Golf_spending > 0 AND Total_Golf_spending < 3000
ORDER BY Total_Dining_spending DESC;

SELECT 
    Member_Number,
    Number_of_member,
    Total_Pool_spending
FROM c
WHERE Number_of_member > 3
ORDER BY Total_Pool_spending DESC;

SELECT
    Participated_Promo1,
    Participated_Promo2,
    AVG(Total_Dining_spending) AS Avg_Dining_Spending,
    AVG(Total_Golf_spending) AS Avg_Golf_Spending,
    AVG(Total_Pool_spending) AS Avg_Pool_Spending,
    AVG(Total_Tennis_spending) AS Avg_Tennis_Spending,
    AVG(Total_Other_spending) AS Avg_Other_Spending,
    AVG(Total_Spending) AS Avg_Total_Spending
FROM c
GROUP BY Participated_Promo1, Participated_Promo2
ORDER BY Participated_Promo1 DESC, Participated_Promo2 DESC;


