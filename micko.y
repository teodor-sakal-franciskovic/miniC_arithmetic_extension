%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "defs.h"
  #include "symtab.h"
  #include "codegen.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);

  extern int yylineno;
  int out_lin = 0;
  char char_buffer[CHAR_BUFFER_LENGTH];
  int error_count = 0;
  int warning_count = 0;
  int var_num = 0;
  int fun_idx = -1;
  int fcall_idx = -1;
  int lab_num = -1;
  
  int lambda_values[100];
  int lambda_fun_param_amounts[100];
  int lambda_fun_param_amounts_position = 0;
  int lambda_values_position = 0;
  int num_of_lambda_arguments = 0;
  int lambda_fun_num = 1;
  int num_of_lambda_params = 0;
  int curr_params = 0;
  int lambda_call_is_active = 0;
  
  unsigned curr_type;
  
  FILE *output;
%}

%union {
  int i;
  char *s;
}

%token <i> _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token <s> _ID
%token <s> _INT_NUMBER
%token <s> _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token _LAMBDA
%token _COLON
%token _COMMA
%token <i> _AROP
%token <i> _PAROP
%token <i> _RELOP

%type <i> num_exp exp literal parop_exp lambda_parameter
%type <i> function_call argument rel_exp if_part lambda_call lambda_argument

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : function_list
      {  
        if(lookup_symbol("main", FUN) == NO_INDEX)
          err("undefined reference to 'main'");
      }
  ;

function_list
  : function
  | function_list function
  ;

function
  : _TYPE _ID
      {
        fun_idx = lookup_symbol($2, FUN);
        if(fun_idx == NO_INDEX)
          fun_idx = insert_symbol($2, FUN, $1, NO_ATR, NO_ATR);
        else 
          err("redefinition of function '%s'", $2);

        code("\n%s:", $2);
        code("\n\t\tPUSH\t%%14");
        code("\n\t\tMOV \t%%15,%%14");
      }
    _LPAREN parameter _RPAREN body
      {
        clear_symbols(fun_idx + 1);
        var_num = 0;
        
        code("\n@%s_exit:", $2);
        code("\n\t\tMOV \t%%14,%%15");
        code("\n\t\tPOP \t%%14");
        code("\n\t\tRET");
      }
  ;

parameter
  : /* empty */
      { set_atr1(fun_idx, 0); }

  | _TYPE _ID
      {
        insert_symbol($2, PAR, $1, 1, NO_ATR);
        set_atr1(fun_idx, 1);
        set_atr2(fun_idx, $1);
      }
  ;

body
  : _LBRACKET variable_list
      {
        if(var_num)
          code("\n\t\tSUBS\t%%15,$%d,%%15", 4*var_num);
        code("\n@%s_body:", get_name(fun_idx));
      }
    statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : _TYPE _ID _SEMICOLON
      {
        if(lookup_symbol($2, VAR|PAR) == NO_INDEX)
           insert_symbol($2, VAR, $1, ++var_num, NO_ATR);
        else 
           err("redefinition of '%s'", $2);
      }
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  | lambda_statement
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("invalid lvalue '%s' in assignment", $1);
        else
          if(get_type(idx) != get_type($3))
            err("incompatible types in assignment");
        gen_mov($3, idx);
      }
  ;

lambda_statement
  : _ID _ASSIGN lambda_exp _SEMICOLON
  {
  	int idx = lookup_symbol($1, LAMBDA_FUN);
  	if (idx == NO_INDEX)
  	{
  	  //atr1 je broj parametara lambda f-je, atr2 redni broj lambda funkcije
  	  insert_symbol($1, LAMBDA_FUN, curr_type, curr_params, lambda_fun_num);
  	  lambda_fun_num++;
  	}
  	else
  	{
  	  err("Lambda function '%s' already exists", $1);
  	}
  }
  ;
  
lambda_exp
  : _LAMBDA lambda_parameters
  {
	lambda_fun_param_amounts[lambda_fun_param_amounts_position] = num_of_lambda_params;
	curr_params = num_of_lambda_params;
	num_of_lambda_params = 0;
	lambda_fun_param_amounts_position++;
  } 
    _COLON num_exp
  ;
  
lambda_parameters
  : lambda_parameter
  | lambda_parameters _COMMA lambda_parameter
  ;
  
lambda_parameter
  : _TYPE _ID
  {	
  	
  	int idx = lookup_lambda_symbol($2, LAMBDA, lambda_fun_num);
  	if (idx == NO_INDEX)
  	{
  	  curr_type = $1;
  	  //atr1 je redni broj lambda funkcije kojoj simbol pripada
  	  insert_symbol($2, LAMBDA, $1, lambda_fun_num, NO_ATR);
  	  int updated_idx = lookup_lambda_symbol($2, LAMBDA, lambda_fun_num);
  	  lambda_values[lambda_values_position] = updated_idx;
	  lambda_values_position++;
	  num_of_lambda_params++;
	  $$ = $1;
  	}
  	else
  	{
  	  err("Lambda variable '%s' already exists!", $2);
  	}
  	
  }
  ;

num_exp
  : parop_exp
  | num_exp _AROP parop_exp
  {
  	if (get_type($1) != get_type($3))
  	{
  		err("Invalid operands for ADD or SUB");
  	}
  	
  	$$ = gen_arop($1, $2, $3);
  }     
  ;
  
parop_exp
  : exp
  | parop_exp _PAROP exp
  {
  	if (get_type($1) != get_type($3))
  	{
  		err("Invalid operands for MUL or DIV");
  	}
  	$$ = gen_arop($1, $2, $3);
  }
  ;

exp
  : literal

  | _ID
      {   
        $$ = lookup_symbol($1, VAR|PAR|LAMBDA);
        if($$ == NO_INDEX)
          err("'%s' undeclared", $1);
        
        if (lambda_call_is_active == 1) {
          int idx = lookup_symbol($1, VAR|PAR);
          if (get_type(idx) != get_type(fcall_idx))
          {
            err("Parameter type isn't matching lambda function's type!");
          }
         }
        
        
        if (lambda_call_is_active == 0) {
          	int idx = lookup_lambda_symbol($1, LAMBDA, lambda_fun_num);
          	//mozda visak ceo ovaj deo, izuci
		if (idx != NO_INDEX)
		{
		
		  int value_exists = 0;
		  int lambda_fun_num_local = get_atr1(idx);
		  int curr_num_of_params = lambda_fun_param_amounts[lambda_fun_num_local - 1];
		  
		  int i;
		  int j;
		  
		  int params_till_curr_fun = 0;
		  for (i = 0; i < 100; i++){
		    if (i < lambda_fun_num - 1){
		      params_till_curr_fun = params_till_curr_fun + lambda_fun_param_amounts[i];
		    }
		    else if (i == lambda_fun_num - 1){
		      break;
		    }
		  }
		  		           
		  for (j = params_till_curr_fun; j < params_till_curr_fun + curr_num_of_params; j++)
		  {
		    if (lambda_values[j] == idx)
		    {
		      value_exists = 1;
		      break;
		    }
		  }
		  
		  if (value_exists == 0)
		  {
		    err("'%s' is not used in this lambda function!\n", $1);
		  }
		}
		else
		{
		     err("'%s' is not declared in lambda parameters, but is used", $1);
		}
        }
        
      }

  | function_call
     {
       $$ = take_reg();
       gen_mov(FUN_REG, $$);
     }
      
  | lambda_call
    {
      $$ = take_reg();
      gen_mov(FUN_REG, $$);
    }
  
  | _LPAREN num_exp _RPAREN
      { $$ = $2; }
  ;

literal
  : _INT_NUMBER
      { $$ = insert_literal($1, INT); }

  | _UINT_NUMBER
      { $$ = insert_literal($1, UINT); }
  ;

function_call
  : _ID 
      {
        fcall_idx = lookup_symbol($1, FUN);
        if(fcall_idx == NO_INDEX)
          err("'%s' is not a function", $1);
      }
    _LPAREN argument _RPAREN
      {
        if(get_atr1(fcall_idx) != $4)
          err("wrong number of arguments");
        code("\n\t\t\tCALL\t%s", get_name(fcall_idx));
        if($4 > 0)
          code("\n\t\t\tADDS\t%%15,$%d,%%15", $4 * 4);
        set_type(FUN_REG, get_type(fcall_idx));
        $$ = FUN_REG;
      }
  ;
  
lambda_call
  : _LAMBDA _ID
      {
        lambda_call_is_active = 1;
        fcall_idx = lookup_symbol($2, LAMBDA_FUN);
        if(fcall_idx == NO_INDEX)
          err("'%s' is not a lambda function", $2);
      }
    _LPAREN lambda_arguments _RPAREN
      {
      	int num_of_args = get_atr1(fcall_idx);
        if(get_atr1(fcall_idx) != num_of_lambda_arguments)
          err("wrong number of arguments '%d', '%d'", num_of_args, num_of_lambda_arguments);
        code("\n\t\t\tCALL\t%s", get_name(fcall_idx));
        int i;
        for (i = 0; i < num_of_lambda_arguments; i++)
        {
          code("\n\t\t\tADDS\t%%15,$%d,%%15", 4);
        }  
        num_of_lambda_arguments = 0;
        set_type(FUN_REG, get_type(fcall_idx));
        $$ = FUN_REG;
        lambda_call_is_active = 0;
      }
  ;
lambda_arguments
  : lambda_argument
  {
  	num_of_lambda_arguments++;
  }
  | lambda_arguments _COMMA lambda_argument
  {
  	num_of_lambda_arguments++;
  }
  ;

argument
  : /* empty */
    { $$ = 0; }

  | num_exp
    { 
      if(get_type(fcall_idx) != get_type($1))
        err("incompatible type for argument '%d' and '%d'", fcall_idx, $1);
      free_if_reg($1);
      code("\n\t\t\tPUSH\t");
      gen_sym_name($1);
      $$ = 1;
    }
  ;
  
lambda_argument
  : num_exp
    {
      if(get_type(fcall_idx) != get_type($1))
        err("incompatible type for argument '%d' and '%d'", fcall_idx, $1);
      free_if_reg($1);
      code("\n\t\t\tPUSH\t");
      gen_sym_name($1);
      $$ = 1;    
    }
  ;

if_statement
  : if_part %prec ONLY_IF
      { code("\n@exit%d:", $1); }

  | if_part _ELSE statement
      { code("\n@exit%d:", $1); }
  ;

if_part
  : _IF _LPAREN
      {
        $<i>$ = ++lab_num;
        code("\n@if%d:", lab_num);
      }
    rel_exp
      {
        code("\n\t\t%s\t@false%d", opp_jumps[$4], $<i>3);
        code("\n@true%d:", $<i>3);
      }
    _RPAREN statement
      {
        code("\n\t\tJMP \t@exit%d", $<i>3);
        code("\n@false%d:", $<i>3);
        $$ = $<i>3;
      }
  ;

rel_exp
  : num_exp _RELOP num_exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: relational operator");
        $$ = $2 + ((get_type($1) - 1) * RELOP_NUMBER);
        gen_cmp($1, $3);
      }
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
      {
        if(get_type(fun_idx) != get_type($2))
          err("incompatible types in return");
        gen_mov($2, FUN_REG);
        code("\n\t\tJMP \t@%s_exit", get_name(fun_idx));        
      }
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;
  init_symtab();
  output = fopen("output.asm", "w+");

  synerr = yyparse();

  clear_symtab();
  fclose(output);
  
  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count) {
    remove("output.asm");
    printf("\n%d error(s).\n", error_count);
  }

  if(synerr)
    return -1;  //syntax error
  else if(error_count)
    return error_count & 127; //semantic errors
  else if(warning_count)
    return (warning_count & 127) + 127; //warnings
  else
    return 0; //OK
}

