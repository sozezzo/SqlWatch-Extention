CREATE OR ALTER FUNCTION [dbo].[ufn_sqlwatch_max_loops_to_runout_space]
(
  @size int,
  @max_size int,
  @growth INT,
  @is_percent_growth bit,
  @freespace int
)
RETURNS INT WITH SCHEMABINDING
AS
BEGIN
	
	SET @size = IIF(@size < 1, 1, @size);
	IF (@freespace < 1) return 0;

	DECLARE @Loops INT = 0;
	DECLARE @maxspace INT = IIF(@freespace > @max_size-@size, @max_size-@size, @freespace );
	
	if (@is_percent_growth = 1)
	BEGIN
		-- by Percent
		DECLARE @j FLOAT = ((@size + @maxspace) / @size ) 
		DECLARE @p FLOAT = (1.0+(@growth/100.0));

		IF (@p < 1) 
		BEGIN
		  SET @Loops = 0;
		END
		ELSE
		BEGIN
		  SET @Loops = LOG ( @j ) / LOG(@p)
		END
    
	END
	ELSE
	BEGIN
		-- by Megabytes
		SET @Loops = @maxspace / @growth;
	END;
	
	RETURN @Loops

END
