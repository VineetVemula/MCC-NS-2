#include<stdio.h>

#include<stdlib.h>

#include<string.h>

int isKeyword(char temp[])

{

	if(strcmp(temp,"int")==0||strcmp(temp,"void")==0||strcmp(temp,"float")==0||strcmp(temp,"main")==0||strcmp(temp,"return")==0)

		return 1;

	else 

		return 0;

}

int isOperator(char temp[])

{

	if(strcmp(temp,"+")==0||strcmp(temp,"=")==0||strcmp(temp,"-")==0||strcmp(temp,"/")==0||strcmp(temp,"*")==0)

		return 1;

	else 

		return 0;

}

int isDel(char temp[])
{

	if(strcmp(temp,";")==0||strcmp(temp,",")==0||strcmp(temp,"(")==0||strcmp(temp,")")==0||strcmp(temp,"{")==0||strcmp(temp,"}")==0)

		return 1;

	else 

		return 0;

}

void lex(char temp[])

{

	int i,j;

	if(isKeyword(temp))

		printf("keyword: %s\n",temp);

	else if(isOperator(temp))

		printf("Operator: %s\n",temp);

	else if(isDel(temp))

		printf("Delimeter: %s\n",temp);

	else

		printf("Variable: %s\n",temp);

}

void main()

{

    char temp[20];

    FILE *fp;

    fp=fopen("program.txt" ,"r");

    while(!feof(fp))

    {

        fscanf(fp,"%s",temp);

        //printf("%s\n",temp);

	lex(temp);

    }

    fclose(fp);

}

int main ( )
{
    int a , b , c ;
    c = a + b ;
    return 0 ;
}

