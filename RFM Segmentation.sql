CREATE DATABASE sample_sales_data;

USE sample_sales_data;


SELECT *
FROM sales_data;

-- RFM_Segmentation


CREATE VIEW RFM_Segmentation AS
WITH CLV AS
(SELECT customername,
MAX(STR_TO_DATE(orderdate,'%d/%m/%y')) AS last_order_date,
DATEDIFF((SELECT MAX(STR_TO_DATE(orderdate,'%d/%m/%y')) FROM sales_data),MAX(STR_TO_DATE(orderdate,'%d/%m/%y'))) AS RECENCY_VALUE,
COUNT(DISTINCT ORDERNUMBER) AS FREQUENCY_VALUE,
ROUND(SUM(sales),0) AS MONETARY_VALUE,
SUM(QUANTITYORDERED) AS Total_quantity_ordered
FROM sales_data
GROUP BY customername),

RFM_Score AS
(SELECT
	C.*,
    NTILE(5) OVER (ORDER BY RECENCY_VALUE DESC) AS R_Score,
    NTILE(5) OVER (ORDER BY FREQUENCY_VALUE ASC) AS F_Score,
    NTILE(5) OVER (ORDER BY MONETARY_VALUE ASC) AS M_Score
FROM CLV AS C),

RFM_Combination AS
(SELECT
 R.*,
 R_score+F_Score+M_Score AS Total_RFM_Score,
CONCAT_WS('',R_score,F_Score,M_Score) AS RFM_Combination
FROM RFM_Score AS R)


SELECT
	C.*,
    CASE 
        WHEN RFM_Combination IN ('555','554','553','552','551','545','544','455','454') 
            THEN 'Champions'
        WHEN RFM_Combination IN ('543','542','541','453','452','451') 
            THEN 'Potential Loyalist'
        WHEN RFM_Combination IN ('535','534','533','532','531','525','524','523',
                                                   '445','444','443','435','434','433','425','424',
                                                   '355','354','353','345','344','335','334','325') 
            THEN 'Loyal Customers'
        WHEN RFM_Combination IN ('522','521','515','514','513','512','442','441',
                                                   '432','431','423','422','421','415','414','413',
                                                   '412','352','351','343','342','341','324','315',
                                                   '314','215','214') 
            THEN 'Promising'
        WHEN RFM_Combination IN ('511','411','311','211') 
            THEN 'New Customers'
        WHEN RFM_Combination IN ('333','332','331','323','322','321','313','312',
                                                   '233','232','231','223','222','221','213','212') 
            THEN 'Needs Attention'
        WHEN RFM_Combination IN ('255','254','253','252','251','245','244','243',
                                                   '242','241','235','234','225','224') 
            THEN 'At Risk'
        WHEN RFM_Combination IN ('155','154','153','152','151','145','144','143',
                                                   '142','141','135','134','133','132','131','125',
                                                   '124','123','122','121','115','114','113','112','111') 
            THEN 'Lost Customers'
        ELSE 'Uncategorized'
END AS Customer_Segment
FROM RFM_Combination AS C;



SELECT customer_segment,
	SUM(monetary_value) AS Total_sales,
    ROUND(AVG(monetary_value),0) AS AVG_Sales,
    SUM(frequency_value) AS Total_Order,
    SUM(total_quantity_ordered) AS Quantity_Ordered
FROM RFM_Segmentation
GROUP BY customer_segment







