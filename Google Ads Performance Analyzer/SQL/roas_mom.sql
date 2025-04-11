--How do ads perform over time? Where are we wasting spend?
CREATE OR REPLACE VIEW ROAS_MoM AS

WITH monthly_roas AS (
    SELECT 
        month,
        campaign_name,
        ROUND(SUM(revenue)::numeric / NULLIF(SUM(cost), 0), 2) AS roas
    FROM shop_data
    GROUP BY month, campaign_name
)

SELECT 
    month,
    campaign_name,
    roas,
    
    -- Previous month ROAS
    LAG(roas) OVER (
        PARTITION BY campaign_name 
        ORDER BY 
            CASE 
                WHEN month = 'January' THEN 1
                WHEN month = 'February' THEN 2
                WHEN month = 'March' THEN 3
                WHEN month = 'April' THEN 4
                WHEN month = 'May' THEN 5
                WHEN month = 'June' THEN 6
                WHEN month = 'July' THEN 7
                WHEN month = 'August' THEN 8
                WHEN month = 'September' THEN 9
                WHEN month = 'October' THEN 10
                WHEN month = 'November' THEN 11
                WHEN month = 'December' THEN 12
                ELSE NULL
            END
    ) AS prev_roas,

    -- MoM change in ROAS
	--Logic (current_month_roas - previous_month_roas) / previous_month_roas

    ROUND(
        (roas - LAG(roas) OVER (
            PARTITION BY campaign_name 
            ORDER BY 
                CASE 
                    WHEN month = 'January' THEN 1
                    WHEN month = 'February' THEN 2
                    WHEN month = 'March' THEN 3
                    WHEN month = 'April' THEN 4
                    WHEN month = 'May' THEN 5
                    WHEN month = 'June' THEN 6
                    WHEN month = 'July' THEN 7
                    WHEN month = 'August' THEN 8
                    WHEN month = 'September' THEN 9
                    WHEN month = 'October' THEN 10
                    WHEN month = 'November' THEN 11
                    WHEN month = 'December' THEN 12
                    ELSE NULL
                END
        )) / NULLIF(LAG(roas) OVER (
            PARTITION BY campaign_name 
            ORDER BY 
                CASE 
                    WHEN month = 'January' THEN 1
                    WHEN month = 'February' THEN 2
                    WHEN month = 'March' THEN 3
                    WHEN month = 'April' THEN 4
                    WHEN month = 'May' THEN 5
                    WHEN month = 'June' THEN 6
                    WHEN month = 'July' THEN 7
                    WHEN month = 'August' THEN 8
                    WHEN month = 'September' THEN 9
                    WHEN month = 'October' THEN 10
                    WHEN month = 'November' THEN 11
                    WHEN month = 'December' THEN 12
                    ELSE NULL
                END
        ), 0), 2
    ) AS mom_roas_change,

    -- 🔻 Flag for low-performing campaigns
    CASE 
        WHEN roas < LAG(roas) OVER(
				PARTITION BY campaign_name
				ORDER BY
					CASE 
                    WHEN month = 'January' THEN 1
                    WHEN month = 'February' THEN 2
                    WHEN month = 'March' THEN 3
                    WHEN month = 'April' THEN 4
                    WHEN month = 'May' THEN 5
                    WHEN month = 'June' THEN 6
                    WHEN month = 'July' THEN 7
                    WHEN month = 'August' THEN 8
                    WHEN month = 'September' THEN 9
                    WHEN month = 'October' THEN 10
                    WHEN month = 'November' THEN 11
                    WHEN month = 'December' THEN 12
                    ELSE NULL
                END
		) THEN '🛑 Wasting Spend'
        ELSE 'Healthy'
    END AS performance_flag
	
FROM monthly_roas
ORDER BY 
    campaign_name,
    CASE 
        WHEN month = 'January' THEN 1
        WHEN month = 'February' THEN 2
        WHEN month = 'March' THEN 3
        WHEN month = 'April' THEN 4
        WHEN month = 'May' THEN 5
        WHEN month = 'June' THEN 6
        WHEN month = 'July' THEN 7
        WHEN month = 'August' THEN 8
        WHEN month = 'September' THEN 9
        WHEN month = 'October' THEN 10
        WHEN month = 'November' THEN 11
        WHEN month = 'December' THEN 12
        ELSE NULL
    END;