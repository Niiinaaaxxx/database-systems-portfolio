# Question 1
#a 
Select Count(Claim_Number)
From claims 
Where Policy_Holder_Id=391;

#b 
Select Claim_Number,STR_TO_DATE(Claim_Date_Filed, "%m/%d/%Y")
From claims 
Where Policy_Holder_Id=391
order by Claim_Date_Filed DESC;

# c
Select Sum(Claim_Amount)
From claims
Where Policy_Holder_Id=391;

# Question 2
Select Gender, SUM(Claim_Amount) As Total_Claim_Amount, AVG(Claim_Amount) AS Average_Claim_Amount
From policyholders
Left Join claims 
ON policyholders.PolicyHolderId = claims.Policy_Holder_Id
WHERE Claim_Type = 'Accident'
Group by policyholders.Gender;

# Question 3
Select Count(PolicyHolderId)
From policyholders
Left Join claims 
ON policyholders.PolicyHolderId = claims.Policy_Holder_Id
Where Claim_Date_Filed is null;                    

# Question 4
Select Claim_Type, 'Claim Time <= 28 Days' AS Category, Count(Claim_Number)
From policyholders
Left Join claims 
ON policyholders.PolicyHolderId = claims.Policy_Holder_Id
Where DATEDIFF(STR_TO_DATE(claims.Claim_Date_Settled, "%m/%d/%Y"),STR_TO_DATE(claims.Claim_Date_Filed, "%m/%d/%Y")) <=28
Group By Claim_Type
Order By Claim_Type;

# Question 5 
Select Count(PolicyHolderId) AS number_policyHolders,number_claims
From(
	Select policyholders.PolicyHolderId, Count(Claim_Number) AS number_claims
	From policyholders
	Left Join claims 
	ON policyholders.PolicyHolderId = claims.Policy_Holder_Id
    Group By PolicyHolderId) AS a
Group by number_claims
Order by number_claims;



# Question 6 
Select PolicyHolderId,Gender,Age,HomeDemo, (2018 - policyholders.YearEnrolled) * policyholders.AnnualPremium AS Total_Premium, IFNULL(SUM(Claim_Amount), 0) AS Total_Claims,
Round((IFNULL(SUM(Claim_Amount), 0))/((2018 - YearEnrolled) * AnnualPremium),4) AS Loss_ratio
From policyholders
Left Join claims 
ON policyholders.PolicyHolderId = claims.Policy_Holder_Id
GROUP BY PolicyHolderId
ORDER BY Loss_ratio DESC
Limit 10
;


# Question 7 
SELECT 
    SUM(total.Total_Premium) AS Total_Premium,
    IFNULL(SUM(total.Total_Claims), 0) AS Total_Claims,
    ROUND(IFNULL(SUM(total.Total_Claims) / SUM(total.Total_Premium), 0), 4) AS Loss_ratio
FROM ( 
    SELECT 
        policyholders.PolicyHolderId, 
        (2018 - policyholders.YearEnrolled) * policyholders.AnnualPremium AS Total_Premium, 
        IFNULL(claim_totals.Total_Claims, 0) AS Total_Claims
    FROM policyholders 
    LEFT JOIN (
        SELECT 
            Policy_Holder_Id, 
            SUM(Claim_Amount) AS Total_Claims 
        FROM claims 
        GROUP BY Policy_Holder_Id
    ) AS claim_totals 
    ON policyholders.PolicyHolderId = claim_totals.Policy_Holder_Id
) AS total 
;

#8
SELECT  
    total.Gender, 
    SUM(total.Total_Premium) AS Total_Premium, 
    IFNULL(SUM(total.Total_Claims), 0) AS Total_Claims, 
    ROUND(IFNULL(SUM(total.Total_Claims) / SUM(total.Total_Premium), 0), 4) AS Loss_ratio
FROM ( 
    SELECT 
        policyholders.PolicyHolderId, 
        policyholders.Gender, 
        (2018 - policyholders.YearEnrolled) * policyholders.AnnualPremium AS Total_Premium, 
        IFNULL(claim_totals.Total_Claims, 0) AS Total_Claims
    FROM policyholders 
    LEFT JOIN (
        SELECT 
            Policy_Holder_Id, 
            SUM(Claim_Amount) AS Total_Claims 
        FROM claims 
        GROUP BY Policy_Holder_Id
    ) AS claim_totals 
    ON policyholders.PolicyHolderId = claim_totals.Policy_Holder_Id
) AS total 
GROUP BY total.Gender 
ORDER BY total.Gender 
;
