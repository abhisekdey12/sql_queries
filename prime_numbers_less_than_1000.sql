declare @limit int=10
        ,@i int=2
        ,@flag smallint=0
        ,@answer varchar(2000)=''
        
while(@i<=@limit)
BEGIN
	Declare @j int=2
    while(@j<@i)
    BEGIN
        IF @i%@j=0
        BEGIN
            SET @flag=1;
			break;
        END
        
        SET @j=@j+1;
    END
    
    if(@flag=0)
    BEGIN
        SET @answer=CONCAT(@answer,CAST(@i as varchar),'&');
    END
    SET @i=@i+1;
	SET @flag=0;
END

select left(@answer,(len(@answer)-1));