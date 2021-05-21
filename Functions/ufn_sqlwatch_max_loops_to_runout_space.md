Function to calculate how many growth loops a file can have before it runs out of space.

```sql
/*
Size = 1000           -- File size
Max file size = 5000  -- Max file size
growth = 10          
percent growth = 1  
@freespace = 2500   -- free space disk 
*/

PRINT [dbo].[ufn_sqlwatch_max_loops_to_runout_space](1000, 5000, 10, 1, 2500)


```
