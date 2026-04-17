select * from `workspace`.`default`.`user_profile`;


select * from `workspace`.`default`.`viewership`;



SELECT 
    v.UserID0,
    v.Channel2,
    v.RecordDate2 AS utc_time,
    from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg') AS sa_time,
    v.`Duration 2`,
    u.name,
    u.Gender,
    u.Race,
    u.Age,
    u.Province
FROM `workspace`.`default`.`viewership` AS v
LEFT JOIN `workspace`.`default`.`user_profile` AS u
ON v.UserID0 = u.UserID;



SELECT
    -- -------------------------------------------------------------------------
    -- USER IDENTIFIERS
    -- -------------------------------------------------------------------------
    v.UserID0,
    u.Name,
    u.Surname,
    u.Email,

    -- -------------------------------------------------------------------------
    -- CHANNEL & DURATION
    -- -------------------------------------------------------------------------
    v.Channel2,
    v.`Duration 2`,
    v.`Duration 2`,

    -- -------------------------------------------------------------------------
    -- FULL DATETIME (already converted to SAST = UTC + 2 hours)
    -- -------------------------------------------------------------------------
    from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'),

    -- -------------------------------------------------------------------------
    -- DATE BREAKDOWNS
    -- -------------------------------------------------------------------------
    DATE(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                            AS session_date,
    YEAR(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                            AS session_year,
    MONTH(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                           AS month_num,
    DATE_FORMAT(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'), 'MMMM')             AS month_name,
    WEEKOFYEAR(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                      AS week_number,
    DAY(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                             AS day_of_month,
    DAYOFWEEK(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                       AS day_of_week,  -- 1=Sunday, 7=Saturday
    DATE_FORMAT(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'), 'EEEE')             AS day_name,

    -- -------------------------------------------------------------------------
    -- TIME BREAKDOWNS
    -- -------------------------------------------------------------------------
    HOUR(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                            AS session_hour,
    MINUTE(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'))                          AS session_minute,
    DATE_FORMAT(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'), 'HH:mm')            AS session_time,

    -- -------------------------------------------------------------------------
    -- WEEKEND FLAG
    -- -------------------------------------------------------------------------
    CASE
        WHEN DAYOFWEEK(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg')) IN (1, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END                                                 AS day_type,

    -- -------------------------------------------------------------------------
    -- TIME SLOT OF DAY
    -- -------------------------------------------------------------------------
    CASE
        WHEN HOUR(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg')) BETWEEN 5  AND 11 THEN 'Morning (05-11h)'
        WHEN HOUR(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg')) BETWEEN 12 AND 16 THEN 'Afternoon (12-16h)'
        WHEN HOUR(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg')) BETWEEN 17 AND 20 THEN 'Prime Time (17-20h)'
        ELSE                                                 'Night (21-04h)'
    END                                                 AS time_slot,

    -- -------------------------------------------------------------------------
    -- USER DEMOGRAPHICS
    -- -------------------------------------------------------------------------
    u.Gender,
    u.Race,
    u.Age,
    u.Province,

    -- -------------------------------------------------------------------------
    -- AGE BAND
    -- -------------------------------------------------------------------------
    CASE
        WHEN u.Age < 25              THEN '18-24'
        WHEN u.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN u.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN u.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE                              '55+'
    END                                                 AS age_band

-- -------------------------------------------------------------------------
-- JOIN BOTH TABLES ON UserID
-- -------------------------------------------------------------------------
FROM `workspace`.`default`.`viewership` AS v
LEFT JOIN `workspace`.`default`.`user_profile` AS u
ON v.UserID0 = u.UserID;



