run :
	@bison -d -t sql_parser.y
	@flex sql_parser.l
	@gcc -ooutput sql_parser.tab.c lex.yy.c -w
	@./output < queries.txt

clean:
	@rm  output lex.yy.c sql_parser.tab.*