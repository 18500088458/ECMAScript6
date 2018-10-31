SELECT  a.name 表名 ,
        b.name 列名
FROM    sysobjects a ,
        syscolumns b
WHERE   a.id = b.id
        AND b.name = '表名'
        AND a.type = 'U';

SELECT  b.name AS TableName ,
        a.name AS columnname
FROM    syscolumns a
        INNER JOIN sysobjects b ON a.id = b.id
                                   AND b.type = 'U'
                                   AND a.name = 'WXMarkingSendId';