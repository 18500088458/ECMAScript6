DECLARE @TableName VARCHAR(100);
SET @TableName = 'RestaurantUser';

SELECT  ( CASE WHEN a.colorder = 1 THEN d.name
               ELSE ''
          END ) ���� ,
        a.colorder �ֶ���� ,
        a.name �ֶ��� ,
        ( CASE WHEN COLUMNPROPERTY(a.id, a.name, 'IsIdentity') = 1 THEN '��'
               ELSE ''
          END ) ��ʶ ,
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
                    ) > 0 THEN '��'
               ELSE ''
          END ) ���� ,
        b.name ���� ,
        a.length ռ���ֽ��� ,
        COLUMNPROPERTY(a.id, a.name, 'PRECISION') AS ���� ,
        ISNULL(COLUMNPROPERTY(a.id, a.name, 'Scale'), 0) AS С��λ�� ,
        ( CASE WHEN a.isnullable = 1 THEN '��'
               ELSE ''
          END ) ����� ,
        ISNULL(e.text, '') Ĭ��ֵ ,
        ISNULL(g.[value], '') AS �ֶ�˵��
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


--CustomerGuid �ͻ����
--UserSeviceGuid Ԥ��Ա���
--UserOwnerGuid Ԥ��Ա���
--RestaurantGuid �������
--CreateTime ����ʱ��
--Deposit 0
--People ����
--MealtimeDay �Ͳ�����
--CustomerName �ͻ�����
--CustomerGender �ͻ��Ա�
--OrderType ��������
--AgentId	������
--CityId	����
--AggregateAmount ��� 0
--OrderStatus ����״̬
--MultiTablingFlag �Ƿ����
--MealTime	--�Ͳ�ʱ��
--RestaurantMealsTimeName �Ͷ�����
--IsSendSms	--�Ƿ��Ͷ���
--IsExceptionOrder	�Ƿ��쳣����
--IsChekced	�Ƿ�˲�
--IsImportant	�Ƿ��ʶ��Ҫ
--RestaurantBanquetId	�͵�����ᣩ����
--ReservationMoney ����

--RestaurantMealsTimeGuid �Ͷα��
--RestaurantMealsTimeClassificationID �Ͷη�����
--CustomerClassificationName �ͻ���������
--RFM ������Ӧ�ͻ���RFM���ͣ�ע��ʲôû�е�ʱ���-00000
--RFMClassifiyId RFM��������
--RFMSubClassifiyId	--������ֵ���ࣨ�������Ӧ������RFM���ࣩ




