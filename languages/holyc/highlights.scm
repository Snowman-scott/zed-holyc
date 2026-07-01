; extends

; --- 1. BYPASS C PARSER ERRORS (extern "c", linkages, and multichar tokens) ---
"extern" @keyword

((ERROR (identifier) @keyword)
 (#eq? @keyword "extern"))

((ERROR (string_literal) @string))

; --- 2. CHARACTERS AND LITERALS (Forced green string mapping) ---
(char_literal) @string
(string_literal) @string
(number_literal) @number

; --- 3. HOLYC PRIMITIVE TYPES & POINTERS ---
((identifier) @type
 (#match? @type "^(I8|I16|I32|I64|U8|U16|U32|U64|F32|F64|U0|Bool|I8i|I16i|I32i|I64i|U8i|U16i|U32i|U64i)$"))

((type_identifier) @type)
((primitive_type) @type)

(pointer_declarator
  declarator: (identifier) @type)

; --- 4. STANDARD & HOLYC KEYWORDS ---
"while" @keyword
"return" @keyword
"if" @keyword
"else" @keyword
"for" @keyword
"switch" @keyword
"case" @keyword
"default" @keyword
"break" @keyword

((identifier) @keyword
 (#match? @keyword "^(auto|asm|_asm|lastclass|no_warn|reg|interrupt)$"))

; --- 5. LITERALS & CONSTANTS ---
((identifier) @constant.builtin
 (#match? @constant.builtin "^(TRUE|FALSE|NULL|true|false)$"))

; --- 6. FUNCTIONS & DECLARATIONS ---
(function_declarator
  declarator: (identifier) @function)

(call_expression
  function: (identifier) @function)

; --- 7. COMMENTS ---
(comment) @comment
(ERROR (comment)) @comment

; --- 8. OPERATORS & POINTER SYMBOLS ---
"+" @operator
"-" @operator
"*" @operator
"/" @operator
"%" @operator
"=" @operator
"==" @operator
"!=" @operator
"<" @operator
">" @operator
"<<" @operator
">>" @operator
"&" @operator
"|" @operator
"^" @operator
"~" @operator
"++" @operator
"--" @operator
