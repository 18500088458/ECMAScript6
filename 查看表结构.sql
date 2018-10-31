DECLARE @TableName VARCHAR(100);
SET @TableName = 'RestaurantUser';

SELECT  ( CASE WHEN a.colorder = 1 THEN d.name
               ELSE ''
          END ) 表名 ,
        a.colorder 字段序号 ,
        a.name 字段名 ,
        ( CASE WHEN COLUMNPROPERTY(a.id, a.name, 'IsIdentity') = 1 THEN '√'
               ELSE ''
          END ) 标识 ,
        ( CASE WHEN ( SELECT    COUNT(*)
                      FROM      sysobjects
                      WHERE     ( name IN (
                                  SELECT    name
                                  FROM      sysindexes
                                  WHERE     ( id = a.id )
                                            AND ( indid IN (
                                                  SELECT    indid
                                                  FROM      sysindexkeys
                                                  WHERE     ( id = a.id )
                                                            AND ( colid IN (
                                                              SELECT
                                                              colid
                                                              FROM
                                                              syscolumns
                                                              WHERE
                                                              ( id = a.id )
                                                              AND ( name = a.name ) ) ) ) ) ) )
                                AND ( xtype = 'PK' )
                    ) > 0 THEN '√'
               ELSE ''
          END ) 主键 ,
        b.name 类型 ,
        a.length 占用字节数 ,
        COLUMNPROPERTY(a.id, a.name, 'PRECISION') AS 长度 ,
        ISNULL(COLUMNPROPERTY(a.id, a.name, 'Scale'), 0) AS 小数位数 ,
        ( CASE WHEN a.isnullable = 1 THEN '√'
               ELSE ''
          END ) 允许空 ,
        ISNULL(e.text, '') 默认值 ,
        ISNULL(g.[value], '') AS 字段说明
FROM    syscolumns a
        LEFT JOIN systypes b ON a.xtype = b.xusertype
        INNER JOIN sysobjects d ON a.id = d.id
                                   AND d.xtype = 'U'
                                   AND d.name <> 'dtproperties'
        LEFT JOIN syscomments e ON a.cdefault = e.id
        LEFT JOIN sys.extended_properties g ON a.id = g.major_id
                                               AND a.colid = g.minor_id
WHERE   d.name = @TableName
ORDER BY a.id ,
        a.colorder; 


--CustomerGuid 客户编号
--UserSeviceGuid 预订员编号
--UserOwnerGuid 预订员编号
--RestaurantGuid 餐厅编号
--CreateTime 创建时间
--Deposit 0
--People 人数
--MealtimeDay 就餐日期
--CustomerName 客户名称
--CustomerGender 客户性别
--OrderType 订单类型
--AgentId	代理商
--CityId	城市
--AggregateAmount 金额 0
--OrderStatus 订单状态
--MultiTablingFlag 是否多桌
--MealTime	--就餐时间
--RestaurantMealsTimeName 餐段名称
--IsSendSms	--是否发送短信
--IsExceptionOrder	是否异常订单
--IsChekced	是否核餐
--IsImportant	是否标识重要
--RestaurantBanquetId	餐单（宴会）类型
--ReservationMoney 订金

--RestaurantMealsTimeGuid 餐段编号
--RestaurantMealsTimeClassificationID 餐段分类编号
--CustomerClassificationName 客户分类名称
--RFM 餐厅对应客户的RFM类型，注意什么没有的时候放-00000
--RFMClassifiyId RFM顶级分类
--RFMSubClassifiyId	--订单价值分类（顶级类对应的子类RFM分类）




