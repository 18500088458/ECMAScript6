SELECT  TABLE_SCHEMA + '.' + TABLE_NAME AS table_name
FROM    SoaMapping a
        RIGHT JOIN INFORMATION_SCHEMA.TABLES b ON a.TableName = b.TABLE_NAME
WHERE   a.TableName IS NULL
        AND b.TABLE_NAME NOT IN (--»ﬂ”‡±Ì
        'User', 'RestaurantUser', 'Restaurant',
        'RestaurantMealsTimeClassification', 'RestaurantBasicInfo' );