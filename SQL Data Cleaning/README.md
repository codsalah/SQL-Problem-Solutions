# Introduction to SQL Data Cleaning
you can get the area code from a phone number using a left function
PULL CHARACTERS FROM THE LEFT SIDE OF THE STRING AND PRESENT THEM AS A SEPARATE STRING

- **LEFT** pulls a specified number of characters for each row in a specified column starting at the beginning (or from the left).
- **RIGHT** pulls a specified number of characters for each row in a specified column starting at the end (or from the right).
- **LENGTH** provides the number of characters for each row of a specified column.

![alt text](<Pasted image 20240621052758.png>)

when using function inside function you should now that the function inside will evaluate first

1. In the **accounts** table, there is a column holding the **website** for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided. Pull these extensions and provide how many of each website type exist in the **accounts** table.  
      
    
2. There is much debate about how much the name or even the first letter of a company name matters. Use the **accounts** table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).  
      
    
3. Use the **accounts** table and a **CASE** statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?  
      
    
4. Consider vowels as `a`, `e`, `i`, `o`, and `u`. What proportion of company names start with a vowel, and what percent start with anything else?